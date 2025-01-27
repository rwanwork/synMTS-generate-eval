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
    input_fn1 = OUTPUT_DIR + "/graphs/07_ranks/ranks.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/08_ranks_graph/ranks.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/08_ranks_graph/ranks.eps"
  shell:
    """
    R/ranks.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/ranks.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Plot_DeepMito_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/07_ranks_deepmito_only/pairwise.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/08_ranks_deepmito_only_graph/pairwise.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/08_ranks_deepmito_only_graph/pairwise.eps"
  shell:
    """
    R/ranks-deepmito.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/ranks-deepmito.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Plot_MitoFates_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/07_ranks_mitofates_only/pairwise.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/08_ranks_mitofates_only_graph/pairwise.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/08_ranks_mitofates_only_graph/pairwise.eps"
  shell:
    """
    R/ranks-mitofates.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/ranks-mitofates.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """




