#####################################################################
##  graph-ranks.smk
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


rule Plot_DeepMito_MitoFates_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/05_ranks_both/ranks.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/06_ranks_both_graph/ranks.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/06_ranks_both_graph/ranks.eps"
  shell:
    """
    R/ranks.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/ranks.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Plot_DeepMito_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/05_ranks_deepmito/pairwise.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/06_ranks_deepmito_graph/pairwise.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/06_ranks_deepmito_graph/pairwise.eps"
  shell:
    """
    R/ranks-deepmito.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/ranks-deepmito.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Plot_MitoFates_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/05_ranks_mitofates/pairwise.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/06_ranks_mitofates_graph/pairwise.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/06_ranks_mitofates_graph/pairwise.eps"
  shell:
    """
    R/ranks-mitofates.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/ranks-mitofates.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Plot_All_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/06_ranks_both_graph/ranks.jpg",
    input_fn2 = OUTPUT_DIR + "/graphs/{group}/06_ranks_both_graph/ranks.eps",
    input_fn3 = OUTPUT_DIR + "/graphs/{group}/06_ranks_deepmito_graph/pairwise.jpg",
    input_fn4 = OUTPUT_DIR + "/graphs/{group}/06_ranks_deepmito_graph/pairwise.eps",
    input_fn5 = OUTPUT_DIR + "/graphs/{group}/06_ranks_mitofates_graph/pairwise.jpg",
    input_fn6 = OUTPUT_DIR + "/graphs/{group}/06_ranks_mitofates_graph/pairwise.eps"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/10_progress/ranks_graphs.txt"
  shell:
    """
    touch {output.output_fn1}
    """


