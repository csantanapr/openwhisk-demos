import pandas as pd
import numpy as np

def main(args):
    dates = pd.date_range('20130101', periods=2)
    df = pd.DataFrame(np.random.randn(2,2), index=dates, columns=list('AB'))
    print(df)
    return df.to_dict('split')
