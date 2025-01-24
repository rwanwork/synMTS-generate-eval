#####################################################################
##  append.smk
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


rule Protein_Append:
  input:
    input_fn1 = OUTPUT_DIR + "/positives/{replicate}/01_random/{method}/mts.fasta",
    input_fn2 = CONFIG_DIR + "/protein/{protein}.fasta"
  output:
    output_fn1 = OUTPUT_DIR + "/positives/{replicate}/02_protein/{method}/{protein}.fasta"
  log:
    log_fn1 = OUTPUT_DIR + "/positives/{replicate}/02_protein/{method}/{protein}.log"
  shell:
    """
    cat {input.input_fn1} | Perl/append-protein.pl --append {input.input_fn2} >{output.output_fn1} 2>{log.log_fn1}
    """
