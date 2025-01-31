#####################################################################
##  complete.smk
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


rule Complete:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/10_progress/ranks_graphs.txt",
    input_fn2 = OUTPUT_DIR + "/graphs/{group}/10_progress/properties_graphs.txt",
    input_fn3 = OUTPUT_DIR + "/graphs/{group}/10_progress/webserver_graphs.txt"
  output:
    output_fn1 = PROGRESS_OUTPUT_DIR + "/graphs/{group}.done"
  shell:
    """
    touch {output.output_fn1}
    """

