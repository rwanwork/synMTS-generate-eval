#####################################################################
##  clean.smk
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


rule Clean_DeepMito:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/main/02_deepmito_parse/{method}_{protein}_{replicate}.json"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/main/03_deepmito_clean/{method}_{protein}_{replicate}.tsv"
  shell:
    """
    cp {input.input_fn1} {output.output_fn1}
    """


rule Clean_MitoFates:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/main/01_mitofates_copy/{protein}_{replicate}.json"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/main/03_mitofates_clean/{protein}_{replicate}.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/main/03_mitofates_clean/{protein}_{replicate}.log"
  shell:
    """
    Perl/clean-mitofates.pl --input {input.input_fn1} >{output.output_fn1} 2>{log.log_fn1}
    """


