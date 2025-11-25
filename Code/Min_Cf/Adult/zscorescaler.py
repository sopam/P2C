
import pandas as pd
import numpy as np

class ZScoreScaler:
    def __init__(self, features_to_scale):
        """
        features_to_scale: list of column names (strings) you want to scale.
        We'll compute means and stddevs for these columns only.
        """
        self.features_to_scale = features_to_scale
        self.means_ = {}
        self.stds_ = {}
        self.is_fitted = False
    
    def fit(self, df: pd.DataFrame):
        """
        Collect mean and stddev for each feature in features_to_scale.
        We'll ignore columns not present or non-numeric in the DataFrame.
        """
        for col in self.features_to_scale:
            if col in df.columns and pd.api.types.is_numeric_dtype(df[col]):
                col_mean = df[col].mean()
                col_std = df[col].std()
                self.means_[col] = col_mean
                self.stds_[col] = col_std
            else:
                # If the col is missing or not numeric, skip or handle as needed
                pass

        self.is_fitted = True
        return self  # Return self to allow chaining (e.g. scaler.fit(df).transform(df))

    def transform(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Create and return a scaled copy of df, using the stored means_ and stds_.
        Columns not in features_to_scale (or not numeric) are left unchanged.
        """
        if not self.is_fitted:
            raise RuntimeError("ZScoreScaler must be fitted before calling transform().")

        # Make a copy so we don't alter the original data
        df_scaled = df.copy()

        # Apply (x - mean) / std for each feature
        for col in self.features_to_scale:
            if col in self.means_:
                # If the std is zero, we could set everything to 0.0 or skip
                std_val = self.stds_[col]
                mean_val = self.means_[col]
                if std_val != 0:
                    df_scaled[col] = (df_scaled[col] - mean_val) / std_val
                else:
                    df_scaled[col] = 0.0
        
        return df_scaled

    def fit_transform(self, df: pd.DataFrame) -> pd.DataFrame:
        """
        Convenience method: fits on df, then returns the transformed df.
        """
        self.fit(df)
        return self.transform(df)
