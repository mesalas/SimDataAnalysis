import matplotlib.pyplot as plt
import sys
import pandas as pd

def plot_price(args):
    out = args[0]
    ins = args[1:]
    fig, ax = plt.subplots(5, figsize=(7, 15))
    for path in ins:
        bars = pd.read_csv(path)
        bars["Close"].plot(ax = ax[0])
        bars["Close"].diff().plot(ax=ax[1])
        bars["Trade Volume"].plot(ax=ax[2])
        pd.plotting.autocorrelation_plot(bars["Close"].diff()[1:], ax = ax[3])
        pd.plotting.autocorrelation_plot(bars["Close"].diff()[1:].abs(), ax=ax[4])

    #limit the x axis for the first 30 days
    for a in [ax[3],ax[4]]:
        a.set_xlim([0,30])
    fig.savefig(out)


if __name__ == "__main__":
    plot_price(sys.argv[1:])
