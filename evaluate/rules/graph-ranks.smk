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


rule Calculate_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/04_deepmito_combine/deepmito.tsv",
    input_fn2 = OUTPUT_DIR + "/graphs/04_mitofates_combine/mitofates.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/07_ranks/ranks.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/07_ranks/ranks.log"
  shell:
    """
    Perl/rank-deepmito-mitofates.pl --deepmito {input.input_fn1} --mitofates {input.input_fn2} --ranks 10,50,100,200,300,400,500,600,700,800,900,1000,2000,4000,6000,8000,10000,11000,12000,13000,14000,15000,16000,17000,20000 --methods 1,2,3,4,5,6,7,8,9 >{output.output_fn1} 2>{log.log_fn1}
    """


rule Plot_Ranks:
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
