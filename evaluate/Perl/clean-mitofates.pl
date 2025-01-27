#!/usr/bin/env perl
#####################################################################
##  clean-mitofates.pl
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

##  Include library for reading in file
use File::Slurper 'read_text';

##  Directories where Perl modules are stored
use lib qw (. ../Common/Perl/ ../../Common/Perl/);


########################################
##  Important variables
########################################

##  Input arguments
my $input_fn_arg = "";


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
$config -> define ("input", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  Input file

##  Process the command-line options
$config -> getopt ();


########################################
##  Validate the settings
########################################

if ($config -> get ("help")) {
  pod2usage (-verbose => 0);
  exit (1);
}

if (!defined ($config -> get ("input"))) {
  printf STDERR "EE\tInput filename required with the --input option!\n";
  exit (1);
}
$input_fn_arg = $config -> get ("input");


########################################
##  Read in entire file
########################################

my $text = read_text ($input_fn_arg);


########################################
##  Remove the surrounding HTML tags
########################################

$text =~ s/<pre>//gs;
$text =~ s/<\/pre>//gs;
chomp ($text);


########################################
##  Remove the header line and split up the name
########################################

##  Split up the file into lines
my @lines = split /\n/, $text;

##  Process from the second line, skipping the header
for (my $k = 1; $k < scalar (@lines); $k++) {
  my @array = split /\t/, $lines[$k];

  my $id = 0;
  my $method = 0;
  my $seed = 0;
  my $protein = "";
  if ($array[0] =~ /^(\d+)_(\d+)_(\d+)_(.+)$/) {
    $id = $1;
    $method = $2;
    $seed = $3;
    $protein = $4;
  }

  printf STDOUT "%s", $array[0];
  printf STDOUT "\t%s", $id;
  printf STDOUT "\t%s", $method;
  printf STDOUT "\t%s", $seed;
  printf STDOUT "\t%s", $protein;

  for (my $j = 1; $j < scalar (@array); $j++) {
    printf STDOUT "\t%s", $array[$j];
  }
  printf STDOUT "\n";
}
