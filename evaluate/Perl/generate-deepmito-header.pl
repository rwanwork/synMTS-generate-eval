#!/usr/bin/env perl
#####################################################################
##  generate-deepmito-header.pl
##
##  Raymond Wan
##    raymond.wan@manchester.ac.uk
##    rwan.work@gmail.com
##
##  Manchester Institute of Biotechnology
##  University of Manchester
##  Manchester, UK
##
##  Copyright (C) 2024-2025, Raymond Wan, All rights reserved.
#####################################################################


use FindBin;
use lib $FindBin::Bin;  ##  Search the directory where the script is located

use diagnostics;
use strict;
use warnings;

##  Include libraries for handling arguments and documentation
use AppConfig;
use AppConfig::Getopt;
use Pod::Usage;

##  Directories where Perl modules are stored
use lib qw (. ../Common/Perl/ ../../Common/Perl/);


########################################
##  Print the header to standard out
########################################

printf STDOUT "Name";
printf STDOUT "\tID";
printf STDOUT "\tMethod";
printf STDOUT "\tSeed";
printf STDOUT "\tGene";
printf STDOUT "\tPredicted";
printf STDOUT "\tScore";
printf STDOUT "\tLength";
printf STDOUT "\tGO_ID";
printf STDOUT "\tGO_Term";
printf STDOUT "\tComments";
printf STDOUT "\n";


