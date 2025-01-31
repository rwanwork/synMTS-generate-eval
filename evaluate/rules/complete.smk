#####################################################################
##  complete.smk
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
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/deepmito.jpg",
    input_fn2 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/deepmito.eps",
    input_fn3 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/mitofates.jpg",
    input_fn4 = OUTPUT_DIR + "/graphs/{group}/05_boxplots/mitofates.eps",
    input_fn5 = OUTPUT_DIR + "/graphs/{group}/06_mts_properties_dist/mts_properties.jpg",
    input_fn6 = OUTPUT_DIR + "/graphs/{group}/06_mts_properties_dist/mts_properties.eps",
    input_fn7 = OUTPUT_DIR + "/graphs/{group}/06_proteins_properties_dist/proteins_properties.jpg",
    input_fn8 = OUTPUT_DIR + "/graphs/{group}/06_proteins_properties_dist/proteins_properties.eps",
    input_fn9 = OUTPUT_DIR + "/graphs/{group}/07_ranks_count/atp8.tsv",
    input_fn10 = OUTPUT_DIR + "/graphs/{group}/07_ranks_count/atp9.tsv",
    input_fn11 = OUTPUT_DIR + "/graphs/{group}/07_ranks_count/cox2.tsv",
    input_fn12 = OUTPUT_DIR + "/graphs/{group}/08_ranks_graph/ranks.jpg",
    input_fn13 = OUTPUT_DIR + "/graphs/{group}/08_ranks_graph/ranks.eps",
    input_fn14 = OUTPUT_DIR + "/graphs/{group}/08_ranks_deepmito_only_graph/pairwise.jpg",
    input_fn15 = OUTPUT_DIR + "/graphs/{group}/08_ranks_deepmito_only_graph/pairwise.eps",
    input_fn16 = OUTPUT_DIR + "/graphs/{group}/08_ranks_mitofates_only_graph/pairwise.jpg",
    input_fn17 = OUTPUT_DIR + "/graphs/{group}/08_ranks_mitofates_only_graph/pairwise.eps"
  output:
    output_fn1 = PROGRESS_OUTPUT_DIR + "/graphs/{group}.done"
  shell:
    """
    touch {output.output_fn1}
    """

