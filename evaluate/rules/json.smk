#####################################################################
##  json.smk
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


rule JSON_to_TSV:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/01_deepmito_copy/{method}_{gene}_{replicate}.json"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/02_deepmito_parse/{method}_{gene}_{replicate}.json"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/02_deepmito_parse/{method}_{gene}_{replicate}.log"
  shell:
    """
    Perl/parse-deepmito.pl --input {input.input_fn1} >{output.output_fn1} 2>{log.log_fn1}
    """


