#!/usr/bin/env perl
#####################################################################
##  create-deepmito-dl.pl
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
##  Important variables
########################################

##  Input arguments
my $replicates_str_arg = "";

##  Data structures
my %replicates_hash;


########################################
##  Subroutines
########################################


########################################
##  Process arguments
########################################

##  Create AppConfig and AppConfig::Getopt objects
my $config = AppConfig -> new ({
  GLOBAL => {
    DEFAULT => undef,      ##  Default value for new variables
  }
});

my $getopt = AppConfig::Getopt -> new ($config);

##  General program options
$config -> define ("help!", {
  ARGCOUNT => AppConfig::ARGCOUNT_NONE
});                        ##  Help screen

##  Program parameters
$config -> define ("replicates", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  List of replicates as a comma-separated list

##  Process the command-line options
$config -> getopt ();


########################################
##  Validate the settings
########################################

if ($config -> get ("help")) {
  pod2usage (-verbose => 0);
  exit (1);
}

if (!defined ($config -> get ("replicates"))) {
  printf STDERR "EE\tComma-separated list of replicates required with the --replicates option!\n";
  exit (1);
}
$replicates_str_arg = $config -> get ("replicates");


########################################
##  Store the replicates of interest
########################################

my @tmp = split /,/, $replicates_str_arg;
for (my $k = 0; $k < scalar (@tmp); $k++) {
  $replicates_hash{$tmp[$k]} = 1;
}


########################################
##  Process the input
########################################

my $header = <STDIN>;  ##  Remove the header

printf STDOUT "#!/bin/bash\n\n";

while (<STDIN>) {
  my $line = $_;
  chomp ($line);

  my ($id, $replicate, $method, $protein, $deepmito) = split /\t/, $line;

  if (defined ($replicates_hash{$replicate})) {
    printf (STDOUT "wget https://busca.biocomp.unibo.it/deepmito/%s/getjson/ -O %u_%s_%u.json\n", $deepmito, $method, $protein, $replicate);
  }
}


