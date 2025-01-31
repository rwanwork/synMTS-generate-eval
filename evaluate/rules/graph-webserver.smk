#####################################################################
##  graph-webserver.smk
##
##  Raymond Wan
##    raymond.wan@manchester.ac.uk
##    rwan.work@gmail.com
##
##  Manchester Institute of Biotechnology
##  University of Manchester
##  Manchester, UK
##
##  Copyright (C) 2025, Raymond Wan, All rights reserved.
#####################################################################


rule ViolinPlot_DeepMito:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/04_deepmito_combine/deepmito.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/08_violin/deepmito.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/08_violin/deepmito.eps"
  shell:
    """
    R/deepmito-violin.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/deepmito-violin.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Boxplot_MitoFates:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/04_mitofates_combine/mitofates.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/08_boxplots/mitofates.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/08_boxplots/mitofates.eps"
  shell:
    """
    R/mitofates-boxplot.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/mitofates-boxplot.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Plot_All_WebServer:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/08_violin/deepmito.jpg",
    input_fn2 = OUTPUT_DIR + "/graphs/{group}/08_violin/deepmito.eps",
    input_fn3 = OUTPUT_DIR + "/graphs/{group}/08_boxplots/mitofates.jpg",
    input_fn4 = OUTPUT_DIR + "/graphs/{group}/08_boxplots/mitofates.eps"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/10_progress/webserver_graphs.txt"
  shell:
    """
    touch {output.output_fn1}
    """


