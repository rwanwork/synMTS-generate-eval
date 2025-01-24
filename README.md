synMTS-generate-eval
====================


Introduction
------------

This repository, **synMTS-generate-eval**, consists of two Snakemake-based workflows whose purposes are to:

1.  Generate synthetic mitochondria targeting sequences (MTS).
2.  Evaluate these sequences.

Besides this document, this repository contains the following:

  * source code in Perl and R,
  * `environment.yml` file for creating a [conda](https://docs.conda.io/en/latest/) environment,
  * licensing information, and
  * data from a sample execution of the workflow.


Requirements
------------

The workflows in this repository uses Snakemake to call Perl and R scripts.  All of this is installed via [Miniforge](https://github.com/conda-forge/miniforge).  In the following table, software that is installed as a `conda` environment are omitted.


| Software                | Version | Required? | Web site                                               |
|:-----------------------:|:-------:|:---------:|:------------------------------------------------------:|
| conda                   | 24.9.2  | Yes       | [Miniforge](https://github.com/conda-forge/miniforge)  |


Experiments with this software have been successfully run on Linux running Ubuntu 24.10.

The versions above represent the tools used during software development. They do not represent the minimum requirements; it is possible that lower versions can be used.

We highly recommend using `conda`.  After cloning this repository, go to the `Common/` directory and create the environment using `conda env create -f environment.yml`, as explained in the online conda [instructions](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#creating-an-environment-from-an-environment-yml-file).


Directory Organisation
----------------------

After cloning this repository from GitHub using the `git clone` command, the following directory structure is obtained (as well as some files of interest):

    .
    ├── Common                             Directories and files shared across workflows
    │   ├── config                           Configuration files
    │   ├── environment-all.yml              Conda environment file (with software versions)
    │   ├── environment.yml                  Conda environment file
    │   ├── Input                            Input directory
    │   └── Output                           Output directory
    ├── Data                               Data directory
    │   ├── mts                              MTS sequences
    │   └── protein                          Passenger protein sequences
    ├── evaluate                           "evaluate" workflow
    │   ├── config -> ../Common/config
    │   ├── Input -> ../Common/Input
    │   ├── Output -> ../Common/Output
    │   ├── Perl                             Perl scripts
    │   ├── R                                R scripts
    │   └── rules                            Snakemake rules
    ├── generate                           "generate" workflow
    │   ├── config -> ../Common/config
    │   ├── Input -> ../Common/Input
    │   ├── Output -> ../Common/Output
    │   ├── Perl                             Perl scripts
    │   └── rules                            Snakemake rules
    ├── LICENSE                            Software license (GNU GPL v3)
    └── README.md                          This README file


Additional documentation
------------------------

In addition to this `README.md`, documentation has been placed at the end of the script in Perl's [PerlPod](https://perldoc.perl.org/perlpod) format.  To view it, you can type `perldoc <name of script>`.

Alternatively, you can just go to the end of the script with your favourite editor.


Running example
---------------

...


Problems
--------

...


Hints
-----

...


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


