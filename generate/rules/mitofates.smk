#####################################################################
##  mitofates.smk
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


def Expand_Methods_MitoFates (wc):
  all_results = []

  for curr_method in config["random"]["methods"]:
    #print ("XXX\t" + curr_seq + "\n", file=sys.stderr)
    curr_result = [OUTPUT_DIR + "/random/{r}/02_protein/{curr}/{p}.fasta".format (r=wc.replicate, curr=curr_method, p=wc.protein)]
    all_results.extend (curr_result)

  print ("Expand_Methods_MitoFates:\t", all_results, file=sys.stderr)

  return all_results


rule Merge_MitoFates:
  input:
    Expand_Methods_MitoFates
  output:
    output_fn1 = OUTPUT_DIR + "/random/{replicate}/05_mitofates/all/{protein}.fasta"
  shell:
    """
    cat {input} >{output.output_fn1}
    """

