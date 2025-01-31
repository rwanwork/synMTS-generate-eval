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
configfile: "config/config.yml"
validate (config, schema = "config/config.schema.yml")

deepmito_panda = pd.read_table (config["deepmito"], sep='\t', lineterminator='\n')
deepmito_panda.set_index ("ID", drop=False, inplace=True)
validate (deepmito_panda, schema="config/deepmito.schema.yml")

mitofates_panda = pd.read_table (config["mitofates"], sep='\t', lineterminator='\n')
mitofates_panda.set_index ("ID", drop=False, inplace=True)
validate (mitofates_panda, schema="config/mitofates.schema.yml")

grouping_panda = pd.read_table (config["grouping"], sep='\t', lineterminator='\n')
grouping_panda.set_index ("ID", drop=False, inplace=True)
validate (grouping_panda, schema="config/grouping.schema.yml")


##################################
##  Define global constraints on wildcards
wildcard_constraints:
  method = "\\d+",
  protein = "atp8|atp9|cox2|hac1",
  replicate = "\\d+",
  grouping = "A|B"


##################################
##  Include additional functions and rules
include:  "config/global-vars.smk"

include:  "rules/copy.smk"
include:  "rules/json.smk"
include:  "rules/clean.smk"
include:  "rules/combine.smk"
include:  "rules/graph-software.smk"
include:  "rules/graph-properties.smk"
include:  "rules/calculate-ranks.smk"
include:  "rules/graph-ranks.smk"

include:  "rules/complete.smk"


##################################
##  Set the shell and the prefix to run before "shell" commands -- activate the conda environment
shell.executable ("/bin/bash")
shell.prefix ("source /opt/miniforge3/etc/profile.d/conda.sh; conda activate mts; ")


##################################
##  Top-level rule
rule all:
  input:
    PROGRESS_OUTPUT_DIR + "/graphs/A.done"

