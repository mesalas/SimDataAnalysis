# Snakemake workflow for calculating stylized facts from trade price returns

## Short description
Calculates:
Daily and 5 min trade price "bars", containing first, last, highest and lowest traded price in that bar length. ie 5 min or one day 
also included is the traded volume.

From the bars the following statistics are calculated:
* auto correlation and absolute auto correlation.
* QQ data for the daily and 5min returns. This can be used to determine how "fat" the tails of the returns distribution is
* a few graphs of the price data on 5 min and daily timescale

## Using
Once snakemake is installed the script can be run using

`snakemake --use-conda -k -j 6 -d [path to data]`

A set of test data can be downloaded at https://www.dropbox.com/sh/oh86eqv2pj91yez/AADcKDlpOA5wTYRprxJVRuHha?dl=0

## Depends on
The script workflow pull the stylized_facts branch of https://github.com/mesalas/amme_data_processing/
Any changes to that branch will be available in the workflow.

The repository contains a number of tests that mimics each of the rules in the snakemake workflow. This makes it possible
to step through the methods to understand the method and debug. To run the tests, place the `test_data` linked above in
the `tests` folder in the repository. (its not committed because snakemake would download the test data each time it runs the workflow. this can be fixed though) 