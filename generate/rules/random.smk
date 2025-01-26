#####################################################################
##  random.smk
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


rule Random_MTS:
  input:
    input_fn1 = AAPROP_FILE
  output:
    output_fn1 = OUTPUT_DIR + "/random/{replicate}/01_random/{method}/mts.fasta"
  log:
    log_fn1 = OUTPUT_DIR + "/random/{replicate}/01_random/{method}/mts.log"
  params:
    method = "{method}",
    number = lambda wildcards: config["random"]["number"],
    minlen = lambda wildcards: config["random"]["minlen"],
    maxlen = lambda wildcards: config["random"]["maxlen"],
    mincharge = lambda wildcards: config["random"]["mincharge"]
  shell:
    """
    Perl/random-mts.pl --method {params.method} --num {params.number} --min {params.minlen} --max {params.maxlen} --mincharge {params.mincharge} --aaprop {input.input_fn1} >{output.output_fn1} 2>{log.log_fn1}
    """

