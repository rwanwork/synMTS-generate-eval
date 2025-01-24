#####################################################################
##  merge-properties.smk
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


def Expand_Methods_MTS_Properties (wc):
  all_results = []

  for curr_method in config["random"]["methods"]:
    #print ("XXX\t" + curr_seq + "\n", file=sys.stderr)
    curr_result = [OUTPUT_DIR + "/positives/{r}/03_mts_prop/{curr}/mts.tsv".format (r=wc.replicate, curr=curr_method)]
    all_results.extend (curr_result)

  print ("Expand_Methods_Properties:\t", all_results, file=sys.stderr)

  return all_results


def Expand_Methods_Proteins_Properties (wc):
  all_results = []

  for curr_method in config["random"]["methods"]:
    #print ("XXX\t" + curr_seq + "\n", file=sys.stderr)
    curr_result = [OUTPUT_DIR + "/positives/{r}/04_pro_prop/{curr}/{p}.tsv".format (r=wc.replicate, curr=curr_method, p=wc.protein)]
    all_results.extend (curr_result)

  print ("Expand_Methods_Properties:\t", all_results, file=sys.stderr)

  return all_results


rule Merge_MTS_Properties:
  input:
    Expand_Methods_MTS_Properties
  output:
    output_fn1 = OUTPUT_DIR + "/positives/{replicate}/06_merged_mts_properties/all/mts.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/positives/{replicate}/06_merged_mts_properties/all/mts.log"
  shell:
    """
    cat {input} | Perl/merge-properties.pl >{output.output_fn1} 2>{log.log_fn1}
    """


rule Merge_Proteins_Properties:
  input:
    Expand_Methods_Proteins_Properties
  output:
    output_fn1 = OUTPUT_DIR + "/positives/{replicate}/06_merged_proteins_properties/all/{protein}.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/positives/{replicate}/06_merged_proteins_properties/all/{protein}.log"
  shell:
    """
    cat {input} | Perl/merge-properties.pl >{output.output_fn1} 2>{log.log_fn1}
    """


