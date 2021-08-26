path = "../temp_data/more_zi_tests/"
data_folder = "working"
ranges = [i for i in range(1,6)]

rule all:
  input:
    expand([path +  data_folder +"{no}/reduced_data/{symbol}_daily_bars.csv.gz"], no = [i for i in ranges], symbol = ["ABC", "DEF", "GHI"])



rule make_bars:
    input:
         "{path}/{symbol}_NYSE@0_Matching-MatchedOrders.csv"
    output:
          "{path}/reduced_data/{symbol}_daily_bars.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python scripts/make_daily_trade_bars.py {input} {output}"

