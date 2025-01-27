synMTS-generate-eval
====================


Introduction
------------

This repository, **synMTS-generate-eval**, consists of two [Snakemake-based](https://snakemake.readthedocs.io/en/stable/) workflows whose purposes are to:

1.  Generate synthetic mitochondria targeting sequences (MTS).
2.  Evaluate these sequences.

In between these two workflows, you will need to submit your MTS to two web servers:  [MitoFates](https://mitf.cbrc.pj.aist.go.jp/MitoFates/cgi-bin/top.cgi) and [DeepMito](https://busca.biocomp.unibo.it/deepmito/).  If you plan to only use one of them, then you will need to edit the workflows.

This repository contains the following:

  * Snakemake workflows in two separate directories,
  * source code in Perl and R,
  * `environment.yml` file for creating a [conda](https://docs.conda.io/en/latest/) environment,
  * licensing information, and
  * data from a sample execution of the workflow.


Installation
------------

The workflows in this repository uses Snakemake to call Perl and R scripts.  All of this is installed via [Miniforge](https://github.com/conda-forge/miniforge).  In the following table, software that is installed as a `conda` environment are omitted.


| Software                | Version | Required? | Web site                                               |
|:-----------------------:|:-------:|:---------:|:------------------------------------------------------:|
| conda                   | 24.9.2  | Yes       | [Miniforge](https://github.com/conda-forge/miniforge)  |


Experiments with this software have been successfully run on Linux running Ubuntu 24.10.

The versions above represent the tools used during software development. They do not represent the minimum requirements; it is possible that lower versions can be used.

As an alternative, you might want to look at `Common/environment.yml` to install each of the software yourself.  If you do decide to use `conda`, then go to the `Common/` directory and create the environment using `conda env create -f environment.yml`, as explained in the online conda [instructions](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-from-an-environment-yml-file).


Directory Organisation
----------------------

After cloning this repository from GitHub using the `git clone` command, **and** running the two workflows, the following file/directory structure is obtained:


    .
    ├── Common                              Directories and files shared across workflows
    │   ├── config                            Configuration files
    │   ├── environment-all.yml               Conda environment file (with software versions)
    │   ├── environment.yml                   Conda environment file
    │   ├── Data                            Data directory
    │   │   ├── mts                           Actual MTS
    │   │   └── protein                       Sample passenger proteins for appending
    │   ├── Input                           Input directory
    │   │   ├── deepmito                      Diretory of sample DeepMito results
    │   │   ├── deepmito.tsv                  List of DeepMito results (not included in repository)
    │   │   ├── mitofates                     Directory of sample MitoFates results
    │   │   └── mitofates.tsv                 List of MitoFates results (not included in repository)
    │   ├── Output                          Output directory
    │   │   ├── graphs                        Output of the "evaluate" workflow
    │   │   ├── Progress                      Location of files set when a workflow has completed successfully
    │   │   │   ├── graphs
    │   │   │   └── random
    │   │   └── random                        Output of the "generate" workflow
    │   │       ├── 1                           Sample replicate #1 of data with only the "01_random" directory
    │   │       ├── 2                           Sample replicate #2 of data with only the "01_random" directory
    │   │       └── 3                           Sample replicate #3 of data with only the "01_random" directory
    │   └── Perl                            Perl modules that could be potentially used by multiple workflows
    ├── evaluate                            "evaluate" workflow
    │   ├── config -> ../Common/config
    │   ├── Data -> ../Common/Data
    │   ├── Input -> ../Common/Input
    │   ├── Output -> ../Common/Output
    │   ├── Perl                              Perl scripts
    │   ├── R                                 R scripts
    │   └── rules                             Snakemake rules
    ├── generate                            "generate" workflow
    │   ├── config -> ../Common/config
    │   ├── Data -> ../Common/Data
    │   ├── Input -> ../Common/Input
    │   ├── Output -> ../Common/Output
    │   ├── Perl                              Perl scripts
    │   └── rules                             Snakemake rules
    ├── LICENSE                             Software license (GNU GPL v3)
    └── README.md                           This README file



Running example
---------------

The example data of 3 replicates and all 9 methods is spread out in two main locations:

* `Common/Output/random/1/`, `Common/Output/random/2/`, and `Common/Output/random/3/`
* `Common/Input/deepmito/` and `Common/Input/mitofates/`

In order to run the example, do the following:

1.  Install the `conda` environment, as described above.
2.  Go into the `Common/Output/` directory and update all of dates of the files.  This command will do:  `find ./ -type f -exec touch {} \;`.
3.  Go into the `generate/` directory and enter `snakemake --snakefile Snakefile.smk --cores 1 -p --dryrun`.  If there are no errors, then repeat the command without `--dryrun`:  `snakemake --snakefile Snakefile.smk --cores 1 -p`.  If the computer you are using has more cores, you can change the `1` to a higher value.
4.  Submit the generated sequences to the DeepMito and MitoFates servers.
5.  Download the results and record them into two tab-separated files:  `Common/Input/deepmito.tsv` and `Common/Input/mitofates.tsv`.  See below for the format of these files.
6.  Go into the `evaluate/` directory and enter `snakemake --snakefile Snakefile.smk --cores 1 -p --dryrun`.  If there are no errors, then repeat the command without `--dryrun`:  `snakemake --snakefile Snakefile.smk --cores 1 -p`.  If the computer you are using has more cores, you can change the `1` to a higher value.

The results from the `generate` workflow can be found in `Common/Output/random/`.

The results from the `evaluate` workflow can be found in `Common/Output/graphs/`.


== Format of the data tables

The tab-separated file `Common/Input/deepmito.tsv` should have a column header as the first row, with the following 5 fields:

* ID -- Unique identifier for each row
* Replicate -- Replicate number
* Method -- Method used (1 -- 9)
* Protein -- Name of the passenger protein appended on
* DeepMito -- Unique identifier for the run

The tab-separated file `Common/Input/mitofates.tsv` should have a column header as the first row, with the following 4 fields:

* ID -- Unique identifier for each row
* Replicate -- Replicate number
* Protein -- Name of the passenger protein appended on
* DeepMito -- Unique identifier for the run


Starting a new data set
-----------------------

In order to start a new data set, after cloning the repository, delete these directories:

* `Common/Output/*`
* `Common/Input/*`

Then, run the workflow as described above.


About synMTS-generate-eval
--------------------------

This software was implemented while I was at the University of Manchester.  My contact details:

     E-mail:  rwan.work@gmail.com

My homepage is [here](http://www.rwanwork.info/).

The latest version can be downloaded from [GitHub](https://github.com/rwanwork/synMTS-generate-eval).

If you have any information about bugs, suggestions for the documentation or just have some general comments, feel free to contact me via e-mail or as a GitHub issue.  (Of the two, I prefer GitHub.)


Copyright and License
---------------------

     synMTS-generate-eval (Generation and evaluation of synthetic MTS)
     Copyright (C) 2025 by Raymond Wan

synMTS-generate-eval is distributed under the terms of the GNU General Public License (GPL, version 3 or later) -- see the file LICENSE for details.

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts and no Back-Cover Texts. A copy of the license is included with the archive as LICENSE.


