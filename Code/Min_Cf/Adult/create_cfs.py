# Function to read the s(CASP) output file and create a DataFrame
def create_dataframe_from_textfile(filename):
    # Read the file
    with open(filename, 'r') as file:
        content = file.read()
    
    # Split the content by ';' to separate instances
    instances = content.strip().split(';')
    # Remove the element as the text file end with a ; so there is nothing as the last element of the list
    instances = instances[:-1]
    
    
    return instances




import re
from collections import defaultdict

def parse_constraints(line):
    # Replace commas with spaces
    line = line.replace(',', ' ')
    
    # Expanded pattern to also match #=< 
    pattern = r'(\w+)\s*(=|#[><]=|#[><]|#=<)\s*(\S+)'

    # Find matches
    matches = re.findall(pattern, line)
    
    grouped_constraints = defaultdict(list)
    for var, op, val in matches:
        grouped_constraints[var].append((op, val))
    
    op_map = {
        '='   : '', 
        '#>'  : '>',
        '#>=' : '>=',
        '#<'  : '<',
        '#<=' : '<=',
        '#=<': '<=',   # Ensure #=< is mapped to <=
    }
    
    result = {}
    for var, constraints in grouped_constraints.items():
        if len(constraints) == 1 and constraints[0][0] == '=':
            # If there's exactly one '=' constraint, treat it as a direct assignment
            result[var] = constraints[0][1]
        else:
            # Combine multiple constraints with ' & '
            pieces = []
            for (op, val) in constraints:
                mapped_op = op_map.get(op, op)  # fallback: use op if not in op_map
                # e.g. "#> 5013" -> ">5013", "#=< 99999" -> "<=99999"
                pieces.append(f"{mapped_op}{val}")
            result[var] = " & ".join(pieces)
    return result





def parse_numeric_constraints(constraint_str):
    """
    E.g. '>5013 & <=99999' -> [('>', 5013), ('<=', 99999)].
    """
    parts = [p.strip() for p in constraint_str.split('&')]
    results = []
    for part in parts:
        match = re.match(r'(>=|<=|>|<|=)(\d+)', part)
        if match:
            op, val_str = match.groups()
            val_num = int(val_str)  # or float if desired
            results.append((op, val_num))
    return results

def satisfies_constraints(x, constraints):
    """
    Checks if numeric x satisfies a list of (op, value) constraints.
    E.g. x=6000, constraints=[('>',5013), ('<=',99999)] => True
    """
    for op, boundary in constraints:
        if op == '>' and not (x > boundary):
            return False
        elif op == '>=' and not (x >= boundary):
            return False
        elif op == '<' and not (x < boundary):
            return False
        elif op == '<=' and not (x <= boundary):
            return False
        elif op == '=' and not (x == boundary):
            return False
    return True




def identify_constraints_and_categoricals(row_dict, columns_of_interest):
    """
    Splits the dictionary into:
      - numeric_constraints: {col: [...list of (op, val)...], ...}
      - fixed_values: {col: 'some_value', ...}  (non-numeric or no constraint)
    """
    filtered = {k: row_dict[k] for k in columns_of_interest if k in row_dict}
    
    numeric_constraints = {}
    fixed_values = {}
    
    for col, val in filtered.items():
        # check if this looks like a range constraint
        if any(op in val for op in ('>', '<', '=')):
            # parse it
            constraints = parse_numeric_constraints(val)
            if constraints: 
                # If parse returns a non-empty list, we treat it as numeric constraints
                numeric_constraints[col] = constraints
            else:
                # If it's something like 'Married-civ-spouse' or parse failed,
                # treat it as a fixed categorical
                fixed_values[col] = val
        else:
            # No operators => treat as fixed
            fixed_values[col] = val
    
    return numeric_constraints, fixed_values




import itertools

def get_k_closest(col, candidate_map, source_row, k=5):
    """
    Returns the k candidates from candidate_map[col] 
    closest to source_row[col].
    """
    source_val = source_row[col]  # the numeric value in your single-row Series
    sorted_candidates = sorted(candidate_map, key=lambda x: abs(x - source_val))
    # Slice top k
    return sorted_candidates[:k]

def expand_to_dataframe_k(row_dict, columns_of_interest, candidate_map, df_series, k):
    """
    1) Identify numeric vs. categorical constraints from row_dict.
    2) For each numeric-constrained column:
       - Filter candidate_map[col] so it only has values that satisfy the constraints.
       - Then pick the k closest values to df_series[col].
    3) Generate all combinations from these trimmed lists + the fixed/categorical values.
    4) Return a DataFrame.
    """

    # 1) Identify numeric constraints & fixed/categorical values
    numeric_constraints, fixed_values = identify_constraints_and_categoricals(row_dict, columns_of_interest)
    
    # 2) Build candidate lists, with constraint-check + distance-based filtering
    constraint_columns = list(numeric_constraints.keys())
    candidate_lists = []
    for col in constraint_columns:
        if col not in candidate_map:
            raise ValueError(f"No candidate list provided for numeric-constrained column '{col}'")

        # 2a) Filter out candidates that fail constraints
        constraints = numeric_constraints[col]
        all_candidates = candidate_map[col]
        valid_candidates = [cand for cand in all_candidates if satisfies_constraints(cand, constraints)]
        
        # 2b) Sort by distance to df_series[col], take top k
        #source_val = df_series[col]
        #print("Source val", source_val)
        trimmed_candidates = get_k_closest(col, valid_candidates, df_series, k)
        
        candidate_lists.append(trimmed_candidates)

    # 3) Generate every combination of the trimmed candidates
    all_rows = []
    for combo in itertools.product(*candidate_lists):
        # We already know they satisfy constraints, but let's keep the old logic
        row_data = dict(fixed_values)  # start with fixed/categorical
        keep = True
        for col, val in zip(constraint_columns, combo):
            # If you really want to skip re-checking constraints here, you can:
            # row_data[col] = val
            # or if you're paranoid, do a final check:
            if satisfies_constraints(val, numeric_constraints[col]):
                row_data[col] = val
            else:
                keep = False
                break

        if keep:
            all_rows.append(row_data)

    # 4) Convert list of dictionaries to a DataFrame
    df = pd.DataFrame(all_rows)

    # 5) Optionally reorder columns
    if set(columns_of_interest).issubset(df.columns):
        df = df[columns_of_interest]

    return df





import pandas as pd
def build_feature_info(df, feature_cols):
    """
    Returns a dictionary that, for each column in feature_cols:
      - If numeric, stores:
          { "range": (min_value, max_value),
            "distinct_values": [all distinct numeric values in ascending order] }
      - If categorical, stores a list of distinct categories.
    """
    feature_info = {}
    
    for col in feature_cols:
        if pd.api.types.is_numeric_dtype(df[col]):
            # Numeric column
            col_min = df[col].min()
            col_max = df[col].max()
            distinct_vals = sorted(df[col].dropna().unique().tolist())
            
            feature_info[col] = {
                "range": (col_min, col_max),
                "distinct_values": distinct_vals
            }
        else:
            # Categorical column: store the distinct categories
            distinct_cats = df[col].dropna().unique().tolist()
            feature_info[col] = distinct_cats
    
    return feature_info



