#!/usr/bin/env perl
#####################################################################
##  merge-properties.pl
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
printf STDOUT "%s\n", $header;

while (<STDIN>) {
  my $line = $_;
  chomp ($line);

  if ($line =~ /^ID/) {
    $num_headers_discarded++;
  }
  else {
    printf STDOUT "%s\n", $line;
    $num_records++;
  }
}

printf STDERR "==\tNumber of records:  %u\n", $num_records;
printf STDERR "==\tHeaders discarded:  %u\n", $num_headers_discarded;


