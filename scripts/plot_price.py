import matplotlib.pyplot as plt
import sys
import pandas as pd

def plot_price(args):
    path,out = args
    bars = pd.read_csv(path)
    fig,ax = plt.subplots()
    bars["Close"].plot(ax = ax)
    fig.show()


if __name__ == "__main__":
    plot_price(sys.argv[1:])
