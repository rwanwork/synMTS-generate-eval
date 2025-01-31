#####################################################################
##  copy.smk
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


rule Copy_DeepMito:
  input:
    input_fn1 = INPUT_DIR + "/deepmito/{method}_{protein}_{replicate}.json"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/main/01_deepmito_copy/{method}_{protein}_{replicate}.json"
  shell:
    """
    cp {input.input_fn1} {output.output_fn1}
    """


rule Copy_MitoFates:
  input:
    input_fn1 = INPUT_DIR + "/mitofates/{protein}_{replicate}.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/main/01_mitofates_copy/{protein}_{replicate}.json"
  shell:
    """
    cp {input.input_fn1} {output.output_fn1}
    """


