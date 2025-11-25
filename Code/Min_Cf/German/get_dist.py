import numpy as np

import pandas as pd


def infer_feature_types(df: pd.DataFrame) -> dict:
    """
    Return a dictionary { column_name: 'numeric' or 'categorical' }
    based on the column's dtype in df.
    
    - If it's numeric (float, int), label it 'numeric'.
    - Otherwise, label it 'categorical'.
      (This covers object, category, bool, string, etc.)
    """
    feature_types = {}
    for col in df.columns:
        if pd.api.types.is_numeric_dtype(df[col].dtype):
            feature_types[col] = 'numeric'
        else:
            feature_types[col] = 'categorical'
    return feature_types



def vector_L0(Feature_Columns, df_cf, reference_row):
    #
    l0_sum = 0
    for col in Feature_Columns:
        # Mismatch is a Series of 0/1
        mismatch_series = (df_cf[col] != reference_row[col]).astype(int)
        # Multiply by the mask O_col
        l0_sum += mismatch_series * df_cf["O_"+col]

    return l0_sum
    

def vector_L1(Feature_Columns, df_cf, reference_row, feature_types):
    #
    l1_sum = 0

    # Split the feature columns by their type
    numeric_cols = [col for col in Feature_Columns if feature_types[col] == 'numeric']
    cat_cols     = [col for col in Feature_Columns if feature_types[col] != 'numeric']

    # Part 1: numeric columns
    for col in numeric_cols:
        diff_series = (df_cf[col] - reference_row[col]).abs()
        l1_sum += diff_series * df_cf["O_"+col]

    # Part 2: categorical columns
    for col in cat_cols:
        mismatch_series = (df_cf[col] != reference_row[col]).astype(int)
        l1_sum += mismatch_series * df_cf["O_"+col]

    return l1_sum
    

def vector_L2(Feature_Columns, df_cf, reference_row, feature_types):
    #
    l2_sq_sum = 0.0

    # Split the feature columns by their type
    numeric_cols = [col for col in Feature_Columns if feature_types[col] == 'numeric']
    cat_cols     = [col for col in Feature_Columns if feature_types[col] != 'numeric']

    # Part 1: numeric columns
    for col in numeric_cols:
        diff_sq_series = (df_cf[col] - reference_row[col])**2
        l2_sq_sum += diff_sq_series * df_cf["O_"+col]

    # Part 2: categorical columns
    for col in cat_cols:
        mismatch_series = (df_cf[col] != reference_row[col]).astype(int)
        l2_sq_sum += mismatch_series * df_cf["O_"+col]

    l2_sum = np.sqrt(l2_sq_sum)

    return l2_sum
    


def add_distance_columns_vectorized(Feature_Columns, df_all_cfs, reference_row, feature_types):
    """
    For each row in df_cf, compute L0, L1, and L2 distances based on the "mask"
    columns (O_<feature>) and store them in columns named 'L0', 'L1', and 'L2'.

    The logic is exactly as before:
      - L0: count of differing features (0 or 1), weighted by O_i.
      - L1: sum of absolute differences (if numeric) or mismatch(1) (if categorical), weighted by O_i.
      - L2: sum of squared differences (if numeric) or mismatch(1) (if categorical), weighted by O_i,
             then take sqrt of that sum.

    We do it in a vectorized way for efficiency.
    """

    

    # --------------------------
    # L0 distance
    # --------------------------
    # L0 is the count of features that differ, weighted by the mask (O_col).
    # For *either* numeric or categorical: mismatch = 1 if values differ, else 0.
    # We'll sum mismatch * O_col across all columns.
    l0_sum =  vector_L0(Feature_Columns, df_all_cfs, reference_row)
    df_all_cfs['L0'] = l0_sum

    # --------------------------
    # L1 distance
    # --------------------------
    # numeric_cols: absolute difference * O_col
    # cat_cols: mismatch (0/1) * O_col
    l1_sum = vector_L1(Feature_Columns, df_all_cfs, reference_row, feature_types)
    df_all_cfs['L1'] = l1_sum

    # --------------------------
    # L2 distance
    # --------------------------
    # numeric_cols: (difference^2) * O_col
    # cat_cols: mismatch(1) * O_col
    # Then take sqrt of the sum.
    l2_sum = vector_L2(Feature_Columns, df_all_cfs, reference_row, feature_types)
    df_all_cfs['L2'] = l2_sum

    return df_all_cfs





def get_k_smallest_points(df, distance_col, k=10):
    """
    Return the k rows from df that have the smallest values
    in the specified distance_col (e.g. 'L0', 'L1', or 'L2').
    """
    # Sort the DataFrame by the chosen distance column
    df_sorted = df.sort_values(by=distance_col)
    
    # Take the top k rows
    k_smallest_df = df_sorted.head(k)
    
    # Get the indices of those rows
    k_smallest_indices = k_smallest_df.index
    
    # Return both
    return k_smallest_df, k_smallest_indices
