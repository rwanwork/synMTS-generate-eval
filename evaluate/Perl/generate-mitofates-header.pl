#!/usr/bin/env perl
#####################################################################
##  generate-mitofates-header.pl
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
printf STDOUT "\tProbability";
printf STDOUT "\tPrediction";
printf STDOUT "\tCleavage_site";
printf STDOUT "\tNet charge";
printf STDOUT "\tTOM20";
printf STDOUT "\tAmphypathic_alpha-helix_position";
printf STDOUT "\tBHHPPP";
printf STDOUT "\tBPHBHH";
printf STDOUT "\tHBHHBb";
printf STDOUT "\tHBHHbB";
printf STDOUT "\tHHBHHB";
printf STDOUT "\tHHBPHB";
printf STDOUT "\tHHBPHH";
printf STDOUT "\tHHBPHP";
printf STDOUT "\tHHHBBH";
printf STDOUT "\tHHHBPH";
printf STDOUT "\tHHHHBB";
printf STDOUT "\tHHPBHH";
printf STDOUT "\tHPBHHP";
printf STDOUT "\tPHHBPH";
printf STDOUT "\n";


