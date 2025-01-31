#####################################################################
##  copy.smk
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


##################################
##  Define local functions
##################################

##  Only take the MTS properties which are from the replicates
##    assigned to the group of interest
def ExpandMTSProperties (wc):
  results = []

  curr_group = wc.group

  for group_row in grouping_panda.itertuples (index = False):
    if wc.group == group_row.Grouping:

      for mitofates_row in mitofates_panda.itertuples (index = False):
        curr_replicate = mitofates_row.Replicate

        if curr_replicate == group_row.Replicate:
          d = [OUTPUT_DIR + "/random/{r}/06_merged_mts_properties/all/mts.tsv".format (r=curr_replicate)]
          results.extend (d)

  print ("ExpandMTSProperties:\t", results, file=sys.stderr)
  print ("ExpandMTSProperties:\t", len (results), file=sys.stderr)

  return results


##  Only take the protein properties which are from the replicates
##    assigned to the group of interest
def ExpandProteinsProperties (wc):
  results = []

  curr_group = wc.group

  for group_row in grouping_panda.itertuples (index = False):
    if wc.group == group_row.Grouping:

      for mitofates_row in mitofates_panda.itertuples (index = False):
        curr_replicate = mitofates_row.Replicate
        curr_protein = mitofates_row.Protein

        if curr_replicate == group_row.Replicate:

          d = [OUTPUT_DIR + "/random/{r}/06_merged_proteins_properties/all/{p}.tsv".format (p=curr_protein, r=curr_replicate)]
          results.extend (d)

  print ("ExpandProteinsProperties:\t", results, file=sys.stderr)
  print ("ExpandProteinsProperties:\t", len (results), file=sys.stderr)

  return results


##################################
##  Define rules
##################################

rule Copy_DeepMito:
  input:
    input_fn1 = INPUT_DIR + "/deepmito/{method}_{protein}_{replicate}.json"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/main/01_deepmito_copy/{method}_{protein}_{replicate}.json"
  shell:
    """
    cp {input.input_fn1} {output.output_fn1}
    """


rule Copy_MitoFates:
  input:
    input_fn1 = INPUT_DIR + "/mitofates/{protein}_{replicate}.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/main/01_mitofates_copy/{protein}_{replicate}.json"
  shell:
    """
    cp {input.input_fn1} {output.output_fn1}
    """


rule Copy_MTS_Properties:
  input:
    ExpandMTSProperties
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/04_mts_properties_combine/mts_properties.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/{group}/04_mts_properties_combine/mts_properties.log"
  shell:
    """
    cat {input} | Perl/clean-properties.pl >{output.output_fn1} 2>{log.log_fn1}
    """


rule Copy_Proteins_Properties:
  input:
    ExpandProteinsProperties
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/04_proteins_properties_combine/proteins_properties.tsv"
  log:
    log_fn1 = OUTPUT_DIR + "/graphs/{group}/04_proteins_properties_combine/proteins_properties.log"
  shell:
    """
    cat {input} | Perl/clean-properties.pl >{output.output_fn1} 2>{log.log_fn1}
    """


