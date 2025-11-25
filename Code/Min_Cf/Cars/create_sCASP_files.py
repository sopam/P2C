import pandas as pd

#s'''
def build_feature_info(df: pd.DataFrame, feature_cols: list) -> dict:
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
#'''


def write_domains(info_dict: dict, output_filename: str):
    """
    Writes Prolog-like facts to a file for each feature in info_dict, with the format:
    
      - Categorical (list of distinct values):
          f_domain(marital_status, 'Never-married').
          f_domain(marital_status, 'Divorced').
          ...
      - Numeric (with min, max range):
          f_domain(capital_gain, X) :- X .>=. 0, X .=<. 99999.

    Where:
      * The feature name is ALWAYS in lowercase.
      * The categorical value is ALWAYS in single quotes.
      * The numeric feature uses the variable X in a single range clause.
    """
    with open(output_filename, "w") as f:
        for feature, data in info_dict.items():
            
            # Convert feature to lowercase
            feature_lower = feature.lower()
            
            # If 'data' is a list, we treat it as categorical
            if isinstance(data, list):
                for cat_value in data:
                    # Write line with single quotes around cat_value,
                    # and feature_lower in place of feature name.
                    f.write(f"f_domain({feature_lower}, '{cat_value}').\n")

            # Otherwise, if it's a dict, we treat it as numeric
            elif isinstance(data, dict):
                col_min, col_max = data["range"]
                f.write(
                    f"f_domain({feature_lower}, X) :- X .>=. {col_min}, X .=<. {col_max}.\n"
                )

    print(f"Domain facts written to {output_filename}")



import os

def write_properties(feature_list, output_filepath):
    """
    Creates (or overwrites) a single file containing lines of the form:

        pre_<feature_lower>(X) :- f_domain(<feature_lower>, X).

        % Post-Intervention world
        post_<feature_lower>(X) :- f_domain(<feature_lower>, X).

    for each feature in `feature_list`.
    """
    with open(output_filepath, "w") as f:
        for feature in feature_list:
            feature_lower = feature.lower()

            lines = [
                "\n% Pre-Intervention world\n",
                f"pre_{feature_lower}(X) :- f_domain({feature_lower}, X).\n",
                "\n% Post-Intervention world\n",
                f"post_{feature_lower}(X) :- f_domain({feature_lower}, X).\n\n"
            ]
            f.writelines(lines)

    print(f"Wrote all feature lines to {output_filepath}")







def write_original_sample_auto(
    df: pd.DataFrame, 
    row_index: int, 
    output_file: str, 
    features_in_order: list, 
    predicate_name):
    """
    1) Use the user-specified `features_in_order` to fix the order of columns
       in the predicate.
    2) For each feature in that list:
       - If df[col] is numeric => use ".=."
       - Otherwise => use "=" with a quoted value.
    3) Write a single row (row_index) to a Prolog-like file with syntax:
       original_sample(Col1, Col2, ..., ColN) :-
           Col1 = 'someStringValue',
           Col2 .=. 1234,
           ...
           ColN = 'someStringValue'.
    """
    # Extract the row as a Series
    row = df.iloc[row_index]

    # Build the predicate head, e.g. original_sample(F1, F2, F3) :-
    head = f"{predicate_name}({', '.join(features_in_order)}) :-"

    # Build the body lines
    body_parts = []
    for col in features_in_order:
        # Check if numeric
        if pd.api.types.is_numeric_dtype(df[col]):
            # numeric => use . = .
            val = row[col]
            body_parts.append(f"    {col} .=. {val}")
        else:
            # categorical or anything else => use =
            val = row[col]
            # wrap the value in single quotes
            body_parts.append(f"    {col} = '{val}'")

    # Join them with commas and end with a period
    body_str = ",\n".join(body_parts) + "."

    # Write to file
    with open(output_file, "w") as f:
        f.write(head + "\n" + body_str + "\n")

    print(f"Wrote predicate to {output_file}")




def write_mutability_predicate(
    mutability_list: list,
    output_file: str,
    predicate_name: str = "mutability"
):
    """
    Given a list (each element can be 0, 1, -1, or 'Z'):
      - If val == 'Z', skip it (no line in the body).
      - Otherwise, write M_i = val.
    If all values are 'Z', write a fact with no ":-" part.

    Example:
      If mutability_list = [0, 1, 'Z', -1], we write:
      
        mutability(M1, M2, M3, M4) :-
            M1 = 0,
            M2 = 1,
            M4 = -1.

      If mutability_list = ['Z', 'Z', 'Z'], we write a fact:
      
        mutability(M1, M2, M3).
    """
    import os
    # Create variable names M1..M<n>
    var_names = [f"Z{i}" for i in range(1, len(mutability_list) + 1)]

    # Build lines for the body
    body_lines = []
    for var_name, val in zip(var_names, mutability_list):
        if val == 'Z':
            continue  # skip
        body_lines.append(f"    {var_name} = {val}")

    # Write to file
    with open(output_file, "w") as f:
        if body_lines:
            # We have at least one non-'Z' => write a rule:
            #   mutability(M1, M2, ...) :-
            #       M1 = 0,
            #       ...
            head = f"{predicate_name}({', '.join(var_names)}) :-"
            body_str = ",\n".join(body_lines) + "."
            f.write(head + "\n" + body_str + "\n")
        else:
            # All were 'Z' => write a fact with no body:
            #   mutability(M1, M2, M3).
            fact_str = f"{predicate_name}({', '.join(var_names)})."
            f.write(fact_str + "\n")

    print(f"Wrote predicate to {os.path.abspath(output_file)}")



def write_weight_predicate(
    weight_list: list,
    output_file: str,
    predicate_name: str = "weight"
):

    import os
    # Create variable names M1..M<n>
    var_names = [f"W{i}" for i in range(1, len(weight_list) + 1)]

    # Build lines for the body
    body_lines = []
    for var_name, val in zip(var_names, weight_list):
        if val == 'W':
            continue  # skip
        body_lines.append(f"    {var_name} = {val}")

    # Write to file
    with open(output_file, "w") as f:
        if body_lines:
            # We have at least one non-'Z' => write a rule:
            #   mutability(M1, M2, ...) :-
            #       M1 = 0,
            #       ...
            head = f"{predicate_name}({', '.join(var_names)}) :-"
            body_str = ",\n".join(body_lines) + "."
            f.write(head + "\n" + body_str + "\n")
        else:
            # All were 'Z' => write a fact with no body:
            #   mutability(M1, M2, M3).
            fact_str = f"{predicate_name}({', '.join(var_names)})."
            f.write(fact_str + "\n")

    print(f"Wrote predicate to {os.path.abspath(output_file)}")
