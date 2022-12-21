#data_path = "../temp_data/run272/"
data_folder = "batch"
ranges = [i for i in range(1,25)]
symbols = ["ABC"]#, "DEF", "GHI"]
freq = "10T"
sim_no_ranges = [i for i in range(0,4)] 
rule all:
  input:
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_daily_close.png"], no = [i for i in ranges], sim_no = sim_no_ranges),
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_5T_price.png"], no = [i for i in ranges], sim_no = sim_no_ranges),
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_{symbol}_daily_bars.csv.gz"], no = [i for i in ranges], symbol = symbols, sim_no = sim_no_ranges),
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_{symbol}_5T_bars.csv.gz"], no = [i for i in ranges], symbol = symbols, sim_no = sim_no_ranges),
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_{symbol}_5T_agent_pos.csv.gz"], no = [i for i in ranges], symbol = symbols, sim_no = sim_no_ranges),
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_{symbol}_daily_agent_pl.csv.gz"], no = [i for i in ranges], symbol = symbols, sim_no = sim_no_ranges),
    expand([data_folder + "{no}/out/reduced_data/{sim_no}_{symbol}_daily_agent_vol.csv.gz"], no = [i for i in ranges], symbol = symbols, sim_no = sim_no_ranges),
    #expand([data_folder + "{no}/out/reduced_data/{sim_no}_{symbol}_{quantile}q_volume_heatmap_{freq}.png"],
    #      no = [i for i in ranges], symbol = symbols, freq = ["5T", "daily"], quantile=[0,1,20], sim_no = sim_no_ranges )
    
    #expand([data_path + data_folder + "reduced_data/{no}_daily_close.png"], no = [i for i in ranges]),
    #expand([data_path + data_folder + "reduced_data/{no}_5T_price.png"], no = [i for i in ranges]),
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_daily_bars.csv.gz"], no = [i for i in ranges], symbol = symbols),
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_5T_bars.csv.gz"], no = [i for i in ranges], symbol = symbols),
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_5T_agent_pos.csv.gz"], no = [i for i in ranges], symbol = symbols),
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_daily_agent_pl.csv.gz"], no = [i for i in ranges], symbol = symbols),
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_daily_agent_vol.csv.gz"], no = [i for i in ranges], symbol = symbols),
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_{quantile}q_volume_heatmap_{freq}.png"],
    #      no = [i for i in ranges], symbol = ["ABC", "DEF", "GHI"], freq = ["5T", "daily"], quantile=[0,1,20] )
    #expand([data_path + data_folder + "reduced_data/{no}_{symbol}_5T_agent_vol.csv.gz"], no = [i for i in ranges], symbol = symbols),



no = 0
rule make_bars:
    input:
         "{path}/{symbol}_NYSE@{no}_Matching-MatchedOrders.csv.gz"
    output:
          "{path}/reduced_data/{no}_{symbol}_daily_bars.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_daily_trade_bars {input} {output}"

rule make_intraday_bars:
    input:
         "{path}/{symbol}_NYSE@{no}_Matching-MatchedOrders.csv.gz"
    output:
          "{path}/reduced_data/{no}_{symbol}_5T_bars.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_intraday_trade_bars 5T {input} {output}"

rule plot_daily_bars:
    input:
         expand(["{{path}}/reduced_data/{{no}}_{symbol}_daily_bars.csv.gz"], symbol = symbols)
    output:
          "{path}/reduced_data/{no}_daily_close.png"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.plotting.plot_price  {output} {input}"


rule plot_intraday_bars:
    input:
         expand(["{{path}}/reduced_data/{{no}}_{symbol}_5T_bars.csv.gz"], symbol = symbols)
    output:
          "{path}/reduced_data/{no}_5T_price.png"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.plotting.plot_intraday_price  {output} {input}"

rule make_agent_pos:
    input:
     "{path}/{symbol}_NYSE@{no}_Matching-agents.csv.gz"
    output:
          "{path}/reduced_data/{no}_{symbol}_5T_agent_pos.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_agent_stat {input} 5T Pos {output}"

rule make_agent_pl:
    input:
     "{path}/{symbol}_NYSE@{no}_Matching-agents.csv.gz"
    output:
          "{path}/reduced_data/{no}_{symbol}_daily_agent_pl.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_agent_stat_daily {input} PL {output}"

rule make_agent_vol:
    input:
     "{path}/{symbol}_NYSE@{no}_Matching-agents.csv.gz"
    output:
          "{path}/reduced_data/{no}_{symbol}_daily_agent_vol.csv.gz"
    conda:
        "envs/deps.yaml"
    shell:
         "python -m adp.make_agent_stat_daily {input} Vol {output}"

#rule make_agent_vol_vol_network:
#    input:
#         "{path}/{symbol}_NYSE@{no}_Matching-MatchedOrders.csv.gz",
#         "{path}/reduced_data/{no}_{symbol}_{freq}_bars.csv.gz"
#    output:
#          #"{path}/reduced_data/{no}_{symbol}_{quantile}q_trading_table_{freq}.csv",
#          "{path}/reduced_data/{no}_{symbol}_{quantile}q_volume_heatmap_{freq}.png",
#          "{path}/reduced_data/{no}_{symbol}_{quantile}q_volume_heatmap_{freq}.csv"
#    conda:
#        "envs/deps.yaml"
#    shell:
#         "python -m adp.make_volatility_and_volume_analysis {input} {output} {wildcards.quantile}"



