#####################################################################
##  graph-software.smk
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


rule Boxplot_DeepMito:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/04_deepmito_combine/deepmito.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/deepmito.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/deepmito.eps"
  shell:
    """
    R/deepmito-violin.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/deepmito-violin.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Boxplot_MitoFates:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/04_mitofates_combine/mitofates.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/mitofates.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/mitofates.eps"
  shell:
    """
    R/mitofates-boxplot.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/mitofates-boxplot.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


