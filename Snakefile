#data_path = "../temp_data/run272/"
data_folder = "batch"
ranges = [i for i in range(0,1)]
symbols = ["ABC"] #, "DEF", "GHI"]

rule all:
  input:
    expand(["{no}_daily_close.png"], no = [i for i in ranges]),
    expand(["{no}_5T_price.png"], no = [i for i in ranges]),
    expand(["{no}_{symbol}_daily_bars.csv.gz"], no = [i for i in ranges], symbol = symbols),
    expand(["{no}_{symbol}_5T_bars.csv.gz"], no = [i for i in ranges], symbol = symbols)



no = 0
rule make_bars:
    input:
         "{symbol}_NYSE@{no}_Matching-MatchedOrders.csv.gz"
    output:
          "{no}_{symbol}_daily_bars.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_daily_trade_bars {input} {output}"

rule make_intraday_bars:
    input:
         "{symbol}_NYSE@{no}_Matching-MatchedOrders.csv.gz"
    output:
          "{no}_{symbol}_5T_bars.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_intraday_trade_bars 5T {input} {output}"

rule plot_daily_bars:
    input:
         expand(["{{no}}_{symbol}_daily_bars.csv.gz"], symbol = symbols)
    output:
          "{no}_daily_close.png"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.plotting.plot_price  {output} {input}"


rule plot_intraday_bars:
    input:
         expand(["{{no}}_{symbol}_5T_bars.csv.gz"], symbol = symbols)
    output:
          "{no}_5T_price.png"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.plotting.plot_intraday_price  {output} {input}"

rule make_daily_returns_auto_correlations:
    input:
         expand(["{{no}}_{symbol}_daily_bars.csv.gz"], symbol = symbols)
    output:
          "{no}_{symbol}_daily_autocorr.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_daily_returns_autocorrelation {output} {input} False"

rule make_daily_abs_returns_auto_correlations:
    input:
         expand(["{{no}}_{symbol}_daily_bars.csv.gz"], symbol = symbols)
    output:
          "{no}_{symbol}_daily_abs_autocorr.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_daily_returns_autocorrelation  {output} {input} True"

rule make_daily_returns_qq_data:
    input:
         expand(["{{no}}_{symbol}_daily_bars.csv.gz"], symbol = symbols)
    output:
          "{no}_{symbol}_daily_returns_qq.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_returns_qq_data  {output} {input}"

rule make_intraday_returns_qq_data:
    input:
         expand(["{{no}}_{symbol}_5T_bars.csv.gz"], symbol = symbols)
    output:
          "{no}_{symbol}_5T_returns_qq.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_returns_qq_data  {output} {input}"


