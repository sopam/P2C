import pandas as pd
from sklearn.preprocessing import StandardScaler


class Preprocess:
    def __init__(self, df_inp, drop_first = False):
        self.df_src = df_inp.copy()
        self.drop_first = drop_first
        #df_encoded = None
        #encoded_cols = None
        #scaler = None
        #numerical_cols = None
        #categorical_cols = None
        self.df_encoded, self.encoded_cols, self.scaler, self.numerical_cols, self.categorical_cols = self.transform_df(self.df_src)

    def convert_bool_to_0_1(self, df_inp):

        df_tmp = df_inp.copy()
        df_tmp = df_tmp.astype({col: int for col in df_tmp.select_dtypes(include='bool').columns})
        return df_tmp

        

    def transform_df(self, df_org):

        df_tmp = df_org.copy()
        # Identify numerical and categorical columns
        numerical_cols = df_tmp.select_dtypes(include=['int64', 'float64']).columns
        categorical_cols = df_tmp.select_dtypes(include=['object', 'category', 'bool']).columns#.drop(lbl_col)

        # Scale numerical features
        scaler = StandardScaler()
        df = df_tmp.copy()
        df[numerical_cols] = scaler.fit_transform(df_tmp[numerical_cols])

        # Encode categorical variables
        df_tmp_encoded = pd.get_dummies(df, columns=categorical_cols, drop_first = self.drop_first)

        # Convert bool to 0/1
        df_tmp_encoded = self.convert_bool_to_0_1(df_tmp_encoded)
        return df_tmp_encoded, df_tmp_encoded.columns, scaler, numerical_cols, categorical_cols


    def exact_column_match_transform_external_df(self, df_ext):

        df_tmp = df_ext.copy()

        #encoded_cols = df_train_encoded.columns
        # Scale numerical features using the SAME scaler (DO NOT fit again!)
        #org_extra_cols = set(df_tmp.columns) - set(self.encoded_cols)
        df_tmp[self.numerical_cols] = self.scaler.transform(df_tmp[self.numerical_cols])
        # One-hot encode using the SAME categorical columns
        df_tmp_encoded = pd.get_dummies(df_tmp, columns=self.categorical_cols,  drop_first = self.drop_first)

        # If the test set misses some dummy columns from training, add them with 0.
        missing_cols = set(self.encoded_cols) - set(df_tmp_encoded.columns)
        for col in missing_cols:
            df_tmp_encoded[col] = 0

        # If the test set has extra columns that weren't in training, drop them.
        extra_cols = set(df_tmp_encoded.columns) - set(self.encoded_cols)
        df_tmp_encoded.drop(extra_cols, axis=1, inplace=True)

        # Reorder the columns to match the training data's order
        df_tmp_encoded = df_tmp_encoded[self.encoded_cols]

        # Convert bool to 0/1
        df_tmp_encoded = self.convert_bool_to_0_1(df_tmp_encoded)
        return df_tmp_encoded
    
    
    def assume_extra_column_transform_external_df(self, df_ext):
        df_tmp = df_ext.copy()
        #encoded_cols = df_train_encoded.columns
        
        # XTRA COLUMNS: Take the extra columns not in df_src and store them elsewhere to add back after preprocessing
            # We want to preserve the same order of the extra columns so we avoid set
        lst_org_extra_cols = [col for col in df_tmp.columns if col not in self.df_src.columns]
            # Set difference is unordered
            #lst_org_extra_cols = list(set(df_tmp.columns) - set(self.df_src.columns))

        df_org_extra_cols = df_tmp.copy()
        df_org_extra_cols = df_org_extra_cols[lst_org_extra_cols]

        # XTRA COLUMNs: Drop the extra columns
        df_tmp = df_tmp.drop(lst_org_extra_cols, axis=1)
        
        # Normal transformation (pre-processing) assuming there was no extra columns between df_tmp and df_src
        df_tmp_encoded = self.exact_column_match_transform_external_df(df_tmp)

        # XTRA COLUMNS:Returening the removed colums from before preprocessing
        df_tmp_encoded[lst_org_extra_cols] = df_org_extra_cols[lst_org_extra_cols]

        # XTRA COLUMNS:Reorder the columns to ensure that the lst_org_extra_cols columns appear first
        #print(lst_org_extra_cols)
        new_col_order = lst_org_extra_cols + [col for col in df_tmp_encoded.columns if col not in lst_org_extra_cols]
        df_tmp_encoded = df_tmp_encoded[new_col_order]

        # Convert bool to 0/1
        df_tmp_encoded = self.convert_bool_to_0_1(df_tmp_encoded)
        return df_tmp_encoded
