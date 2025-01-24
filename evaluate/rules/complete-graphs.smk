#####################################################################
##  complete-graphs.smk
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


rule Complete_Graphs:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/05_boxplots/deepmito.jpg",
    input_fn2 = OUTPUT_DIR + "/graphs/05_boxplots/deepmito.eps",
    input_fn3 = OUTPUT_DIR + "/graphs/05_boxplots/mitofates.jpg",
    input_fn4 = OUTPUT_DIR + "/graphs/05_boxplots/mitofates.eps",
    input_fn5 = OUTPUT_DIR + "/graphs/06_mts_properties_dist/mts_properties.jpg",
    input_fn6 = OUTPUT_DIR + "/graphs/06_mts_properties_dist/mts_properties.eps",
    input_fn7 = OUTPUT_DIR + "/graphs/06_proteins_properties_dist/proteins_properties.jpg",
    input_fn8 = OUTPUT_DIR + "/graphs/06_proteins_properties_dist/proteins_properties.eps",
    input_fn9 = OUTPUT_DIR + "/graphs/08_ranks_graph/ranks.jpg",
    input_fn10 = OUTPUT_DIR + "/graphs/08_ranks_graph/ranks.eps"
  output:
    output_fn1 = PROGRESS_OUTPUT_DIR + "/graphs/all.done"
  shell:
    """
    touch {output.output_fn1}
    """


