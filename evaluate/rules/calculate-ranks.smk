#####################################################################
##  calculate-ranks.smk
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


rule Calculate_DeepMito_MitoFates_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/04_deepmito_combine/deepmito.tsv",
    input_fn2 = OUTPUT_DIR + "/graphs/04_mitofates_combine/mitofates.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/07_ranks/ranks.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/07_ranks/ranks.log"
  shell:
    """
    ranks_list="10,50,100,200,300,400,500,600,700,800,900,1000,2000,4000,6000,8000,10000,11000,12000,13000,14000,15000,16000,17000,20000"
    methods_list="1,2,3,4,5,6,7,8,9"

    Perl/rank-deepmito-mitofates.pl --deepmito {input.input_fn1} --mitofates {input.input_fn2} --ranks ${{ranks_list}} --methods ${{methods_list}}  >{output.output_fn1} 2>{log.log_fn1}
    """


rule Calculate_DeepMito_Ranks:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/04_deepmito_combine/deepmito.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/07_ranks_deepmito_only/pairwise.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/07_ranks_deepmito_only/pairwise.log"
  shell:
    """
    ranks_list="10,50,100,125,250,375,500,625,750,875,1000,1125,1200"
    methods_list="4,7"

    Perl/rank-deepmito.pl --deepmito {input.input_fn1} --protein1 atp8 --protein2 atp9 --ranks ${{ranks_list}} --methods ${{methods_list}} >{output.output_fn1} 2>{log.log_fn1}

    Perl/rank-deepmito.pl --deepmito {input.input_fn1} --protein1 atp8 --protein2 cox2 --ranks ${{ranks_list}} --methods ${{methods_list}} >>{output.output_fn1} 2>>{log.log_fn1}

    Perl/rank-deepmito.pl --deepmito {input.input_fn1} --protein1 atp9 --protein2 cox2 --ranks ${{ranks_list}} --methods ${{methods_list}} >>{output.output_fn1} 2>>{log.log_fn1}
    """


rule Calculate_DeepMito_Count:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/04_deepmito_combine/deepmito.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/07_ranks_count/atp8.tsv",
    output_fn2 = OUTPUT_DIR + "/graphs/07_ranks_count/atp9.tsv",
    output_fn3 = OUTPUT_DIR + "/graphs/07_ranks_count/cox2.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/07_ranks_count/atp8.log",
    log_fn2 = OUTPUT_DIR + "/graphs/07_ranks_count/atp9.log",
    log_fn3 = OUTPUT_DIR + "/graphs/07_ranks_count/cox2.log"
  shell:
    """
    methods_list="4,7"

    Perl/rank-deepmito-count.pl --deepmito Output/graphs/04_deepmito_combine/deepmito.tsv --protein1 atp8 --methods ${{methods_list}} >{output.output_fn1} 2>{log.log_fn1}
    Perl/rank-deepmito-count.pl --deepmito Output/graphs/04_deepmito_combine/deepmito.tsv --protein1 atp9 --methods ${{methods_list}} >{output.output_fn2} 2>{log.log_fn2}
    Perl/rank-deepmito-count.pl --deepmito Output/graphs/04_deepmito_combine/deepmito.tsv --protein1 cox2 --methods ${{methods_list}} >{output.output_fn3} 2>{log.log_fn3}
    """

