#####################################################################
##  properties.smk
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


rule Protein_Properties:
  input:
    input_fn1 = OUTPUT_DIR + "/random/{replicate}/02_protein/{method}/{protein}.fasta",
    input_fn2 = AAPROP_FILE
  output:
    output_fn1 = OUTPUT_DIR + "/random/{replicate}/04_pro_prop/{method}/{protein}.tsv",
    output_fn2 = OUTPUT_DIR + "/random/{replicate}/04_pro_prop/{method}/{protein}.fasta"
  log:
    log_fn1 = OUTPUT_DIR + "/random/{replicate}/04_pro_prop/{method}/{protein}.log"
  shell:
    """
    cat {input.input_fn1} | Perl/aa-properties.pl --aaprop {input.input_fn2} --stats {output.output_fn1} >{output.output_fn2} 2>{log.log_fn1}
    """


rule MTS_Properties:
  input:
    input_fn1 = OUTPUT_DIR + "/random/{replicate}/01_random/{method}/mts.fasta",
    input_fn2 = AAPROP_FILE
  output:
    output_fn1 = OUTPUT_DIR + "/random/{replicate}/03_mts_prop/{method}/mts.tsv",
    output_fn2 = OUTPUT_DIR + "/random/{replicate}/03_mts_prop/{method}/mts.fasta"
  log:
    log_fn1 = OUTPUT_DIR + "/random/{replicate}/03_mts_prop/{method}/mts.log"
  shell:
    """
    cat {input.input_fn1} | Perl/aa-properties.pl --aaprop {input.input_fn2} --stats {output.output_fn1} >{output.output_fn2} 2>{log.log_fn1}
    """

