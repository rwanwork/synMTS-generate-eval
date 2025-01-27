#!/usr/bin/env perl
#####################################################################
##  clean-properties.pl
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
##  Important variables
########################################


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

##  Process the command-line options
$config -> getopt ();


########################################
##  Validate the settings
########################################

if ($config -> get ("help")) {
  pod2usage (-verbose => 0);
  exit (1);
}


########################################
##  Process the file
########################################

my $num_records = 0;
my $num_headers_discarded = 0;

##  Keep only the first header
my $header = <STDIN>;
chomp ($header);
my @header_array = split /\t/, $header;
printf STDOUT "Name\tID\tMethod\tSeed\tProtein";
for (my $k = 1; $k < scalar (@header_array); $k++) {
  printf STDOUT "\t%s", $header_array[$k];
}
printf STDOUT "\n";

while (<STDIN>) {
  my $line = $_;
  chomp ($line);

  if ($line =~ /^ID/) {
    $num_headers_discarded++;
  }
  else {
    my @array = split /\t/, $line;

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
    elsif ($array[0] =~ /^(\d+)_(\d+)_(\d+)$/) {
      $id = $1;
      $method = $2;
      $seed = $3;
      $protein = "N/A";
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

    $num_records++;
  }
}

printf STDERR "==\tNumber of records:  %u\n", $num_records;
printf STDERR "==\tHeaders discarded:  %u\n", $num_headers_discarded;

