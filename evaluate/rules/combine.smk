#####################################################################
##  combine.smk
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

##  Only take the DeepMito output which are from the replicates
##    assigned to the group of interest
def ExpandDeepMito (wc):
  results = []

  curr_group = wc.group

  for group_row in grouping_panda.itertuples (index = False):
    if wc.group == group_row.Grouping:
      for deepmito_row in deepmito_panda.itertuples (index = False):
        curr_replicate = deepmito_row.Replicate
        curr_method = deepmito_row.Method
        curr_protein = deepmito_row.Protein

        if curr_replicate == group_row.Replicate:
          d = [OUTPUT_DIR + "/graphs/main/03_deepmito_clean/{m}_{p}_{r}.tsv".format (m=curr_method, p=curr_protein, r=curr_replicate)]
          results.extend (d)

  print ("ExpandDeepMito:\t", results, file=sys.stderr)
  print ("ExpandDeepMito:\t", len (results), file=sys.stderr)

  return results


##  Only take the MitoFates output which are from the replicates
##    assigned to the group of interest
def ExpandMitoFates (wc):
  results = []

  curr_group = wc.group

  for group_row in grouping_panda.itertuples (index = False):
    if wc.group == group_row.Grouping:
      for mitofates_row in mitofates_panda.itertuples (index = False):
        curr_replicate = mitofates_row.Replicate
        curr_protein = mitofates_row.Protein

        if curr_replicate == group_row.Replicate:
          d = [OUTPUT_DIR + "/graphs/main/03_mitofates_clean/{p}_{r}.tsv".format (p=curr_protein, r=curr_replicate)]
          results.extend (d)

  print ("ExpandMitoFates:\t", results, file=sys.stderr)
  print ("ExpandMitoFates:\t", len (results), file=sys.stderr)

  return results


##################################
##  Define rules
##################################

rule Combine_DeepMito:
  input:
    ExpandDeepMito
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/04_deepmito_combine/deepmito.tsv"
  shell:
    """
    Perl/generate-deepmito-header.pl >{output.output_fn1}
    cat {input} >>{output.output_fn1}
    """


rule Combine_MitoFates:
  input:
    ExpandMitoFates
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/04_mitofates_combine/mitofates.tsv"
  shell:
    """
    Perl/generate-mitofates-header.pl >{output.output_fn1}
    cat {input} >>{output.output_fn1}
    """


