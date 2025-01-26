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


def Expand_NonMTS (wc):
  all_results = []

  for curr_seq in config["protein"]["sequences"]:
    #print ("XXX\t" + curr_seq + "\n", file=sys.stderr)
    curr_result = [OUTPUT_DIR + "/random/{r}/05_mitofates/all/{curr}.fasta".format (r=wc.replicate, curr=curr_seq)]
    all_results.extend (curr_result)
    curr_result = [OUTPUT_DIR + "/random/{r}/06_merged_proteins_properties/all/{curr}.tsv".format (r=wc.replicate, curr=curr_seq)]
    all_results.extend (curr_result)

  print ("Expand_NonMTS:\t", all_results, file=sys.stderr)

  return all_results


def Expand_Methods (wc):
  all_results = []

  for method in config["random"]["methods"]:
    #print ("XXX\t" + method + "\n", file=sys.stderr)
    curr_result = [OUTPUT_DIR + "/random/{r}/07_nonmts_all/{m}/non_mts.done".format (m=method, r=wc.replicate)]
    all_results.extend (curr_result)

  curr_result = [OUTPUT_DIR + "/random/{r}/06_merged_mts_properties/all/mts.tsv".format (r=wc.replicate)]
  all_results.extend (curr_result)

  print ("Expand_Methods:\t", all_results, file=sys.stderr)

  return all_results


rule Complete_NonMTS:
  input:
    Expand_NonMTS
  output:
    output_fn1 = OUTPUT_DIR + "/random/{replicate}/07_nonmts_all/{method}/non_mts.done"
  shell:
    """
    touch {output.output_fn1}
    """


rule Complete_All:
  input:
    Expand_Methods
  output:
    output_fn1 = PROGRESS_OUTPUT_DIR + "/random/{replicate}.done"
  shell:
    """
    touch {output.output_fn1}
    """
