#####################################################################
##  graph-properties.smk
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


rule Dist_Proteins_Properties:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/04_proteins_properties_combine/proteins_properties.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/07_proteins_properties/proteins_properties.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/07_proteins_properties/proteins_properties.eps"
  shell:
    """
    R/properties-dist.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/properties-dist.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    """


rule Dist_MTS_Properties:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/04_mts_properties_combine/mts_properties.tsv"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_properties.jpg",
    output_fn2 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_properties.eps",
    output_fn3 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_length.jpg",
    output_fn4 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_length.eps",
    output_fn5 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_charge.jpg",
    output_fn6 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_charge.eps"
  shell:
    """
    R/properties-dist.R --type jpg --input {input.input_fn1} --output {output.output_fn1}
    R/properties-dist.R --type eps --input {input.input_fn1} --output {output.output_fn2}
    R/properties-length.R --type jpg --input {input.input_fn1} --output {output.output_fn3}
    R/properties-length.R --type eps --input {input.input_fn1} --output {output.output_fn4}
    R/properties-charge.R --type jpg --input {input.input_fn1} --output {output.output_fn5}
    R/properties-charge.R --type eps --input {input.input_fn1} --output {output.output_fn6}
    """


rule Plot_All_Properties:
  input:
    input_fn1 = OUTPUT_DIR + "/graphs/{group}/07_proteins_properties/proteins_properties.jpg",
    input_fn2 = OUTPUT_DIR + "/graphs/{group}/07_proteins_properties/proteins_properties.eps",
    input_fn3 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_properties.jpg",
    input_fn4 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_properties.eps",
    input_fn5 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_length.jpg",
    input_fn6 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_length.eps",
    input_fn7 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_charge.jpg",
    input_fn8 = OUTPUT_DIR + "/graphs/{group}/07_mts_properties/mts_charge.eps"
  output:
    output_fn1 = OUTPUT_DIR + "/graphs/{group}/10_progress/properties_graphs.txt"
  shell:
    """
    touch {output.output_fn1}
    """


