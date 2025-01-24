#####################################################################
##  Snakefile.smk
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

import pandas as pd

from snakemake.utils import validate, min_version

##  Set the minimum snakemake version
min_version ("7.0")


##################################
##  Configuration files
configfile: "Common/config/config.yml"
validate (config, schema = "Common/config/config.schema.yml")


##################################
##  Define global constraints on wildcards
wildcard_constraints:
  replicate = "\\d+",
  method = "\\d+"


##################################
##  Include additional functions and rules
include:  "Common/config/global-vars.smk"

include:  "rules/random.smk"
include:  "rules/append.smk"
include:  "rules/mitofates.smk"
include:  "rules/properties.smk"
include:  "rules/merge-properties.smk"

include:  "rules/complete-random.smk"


##################################
##  Set the shell and the prefix to run before "shell" commands -- activate the conda environment
shell.executable ("/bin/bash")
shell.prefix ("source /opt/miniforge3/etc/profile.d/conda.sh; conda activate mts; ")


##################################
##  Top-level rule
rule all:
  input:
    PROGRESS_OUTPUT_DIR + "/positives/1.done",
    PROGRESS_OUTPUT_DIR + "/positives/2.done",
    PROGRESS_OUTPUT_DIR + "/positives/3.done"

