#!/usr/bin/env perl
#####################################################################
##  rank-deepmito.pl
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

use Access_IDs;
use Sort_DeepMito;


########################################
##  Important variables
########################################

##  Input arguments
my $deepmito_fn_arg = "";
my $protein1_arg = "";
my $protein2_arg = "";
my $ranks_str_arg = "";
my $methods_str_arg = "";
my $shownames_arg = 0;
my $debug_arg = 0;

##  Data structures
my @deepmito1;
my @deepmito2;
my %methods_hash;


########################################
##  Subroutines
########################################

##  Sort using explicit subroutine name on the scores
sub deepmito_cmpfn {
  my @x_array = split /\t/, $a;
  my $x = $x_array[2];

  my @y_array = split /\t/, $b;
  my $y = $y_array[2];

  ##  Numerical sort in decreasing order
  $y <=> $x;
}


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
$config -> define ("debug!", {
  ARGCOUNT => AppConfig::ARGCOUNT_NONE
});                        ##  Debug mode
$config -> define ("deepmito", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  File of DeepMito output
$config -> define ("protein1", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  First protein
$config -> define ("protein2", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  Second protein
$config -> define ("ranks", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  List of ranks as a comma-separated list
$config -> define ("methods", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  List of methods as a comma-separated list
$config -> define ("shownames!", {
  ARGCOUNT => AppConfig::ARGCOUNT_NONE
});                        ##  Show names of overlaps

##  Process the command-line options
$config -> getopt ();


########################################
##  Validate the settings (mandatory arguments)
########################################

if ($config -> get ("help")) {
  pod2usage (-verbose => 0);
  exit (1);
}

$debug_arg = 0;
if ($config -> get ("debug")) {
  $debug_arg = 1;
}

if (!defined ($config -> get ("deepmito"))) {
  printf STDERR "EE\tDeepMito output required with the --deepmito option!\n";
  exit (1);
}
$deepmito_fn_arg = $config -> get ("deepmito");

if (!defined ($config -> get ("protein1"))) {
  printf STDERR "EE\tName of first protein required with the --protein1 option!\n";
  exit (1);
}
$protein1_arg = $config -> get ("protein1");

if (!defined ($config -> get ("protein2"))) {
  printf STDERR "EE\tName of second protein required with the --protein2 option!\n";
  exit (1);
}
$protein2_arg = $config -> get ("protein2");

if (!defined ($config -> get ("ranks"))) {
  printf STDERR "EE\tComma-separated list of ranks required with the --ranks option!\n";
  exit (1);
}
$ranks_str_arg = $config -> get ("ranks");

if (!defined ($config -> get ("methods"))) {
  printf STDERR "EE\tComma-separated list of methods required with the --methods option!\n";
  exit (1);
}
$methods_str_arg = $config -> get ("methods");


########################################
##  Validate the settings (optional arguments)
########################################

$shownames_arg = 0;
if ($config -> get ("shownames")) {
  $shownames_arg = 1;
}


########################################
##  Print out the options used
########################################

printf STDERR "==\tRequired arguments:\n";
printf STDERR "==\t  DeepMito filename:  %s\n", $deepmito_fn_arg;
printf STDERR "==\t  Protein 1:  %s\n", $protein1_arg;
printf STDERR "==\t  Protein 2:  %s\n", $protein2_arg;
printf STDERR "==\t  List of ranks:  %s\n", $ranks_str_arg;
printf STDERR "==\t  List of methods:  %s\n", $methods_str_arg;
printf STDERR "==\tOptional arguments:\n";
if ($shownames_arg == 1) {
  printf STDERR "==\t  Show sequence names:  Yes\n";
}
else {
  printf STDERR "==\t  Show sequence names:  No\n";
}


########################################
##  Store the methods of interest
########################################

my @methods = split /,/, $methods_str_arg;
for (my $k = 0; $k < scalar (@methods); $k++) {
  $methods_hash{$methods[$k]} = 1;
}


########################################
##  Read in the DeepMito file
########################################

my $deepmito_count = 0;
my $deepmito_count1 = 0;
my $deepmito_count2 = 0;

open (my $deepmito_fp, "<", $deepmito_fn_arg) or die "EE\tCould not open $deepmito_fn_arg for input!\n";
my $header = <$deepmito_fp>;  ##  Discard the header
while (<$deepmito_fp>) {
  my $line = $_;
  chomp ($line);

  my @tmp_array = split /\t/, $line;

  ##  Name, predicted [yes/no], score
  my $record = $tmp_array[0]."\t".$tmp_array[5]."\t".$tmp_array[6];

  my $curr_method = GetMethodFromName ($tmp_array[0]);
  if (!defined ($methods_hash{$curr_method})) {
    next;
  }

  my $curr_protein = GetProteinFromName ($tmp_array[0]);

  if ($curr_protein eq $protein1_arg) {
    push (@deepmito1, $record);
    $deepmito_count1++;
  }
  if ($curr_protein eq $protein2_arg) {
    push (@deepmito2, $record);
    $deepmito_count2++;
  }
  $deepmito_count++;
}
close ($deepmito_fp);


printf STDERR "==\t%u %u %u\n", $deepmito_count, $deepmito_count1, $deepmito_count2;


########################################
##  Sort the two arrays
########################################

my @sorted_deepmito1 = sort deepmito_cmpfn @deepmito1;
my @sorted_deepmito2 = sort deepmito_cmpfn @deepmito2;


printf STDERR "==\t%u %u\n", scalar (@sorted_deepmito1), scalar (@sorted_deepmito2);


########################################
##  Debug mode; print the arrays out (long output!)
########################################

if ($debug_arg == 1) {
  for (my $k = 0; $k < scalar (@sorted_deepmito1); $k++) {
    printf STDERR "[1 %u] %s", $k, GetDeepMito_Name ($sorted_deepmito1[$k]);
    printf STDERR "\t%s", GetDeepMito_Predicted ($sorted_deepmito1[$k]);
    printf STDERR "\t%f", GetDeepMito_Score ($sorted_deepmito1[$k]);
    printf STDERR "\n";
  }

  for (my $k = 0; $k < scalar (@sorted_deepmito2); $k++) {
    printf STDERR "[2 %u] %s", $k, GetDeepMito_Name ($sorted_deepmito2[$k]);
    printf STDERR "\t%s", GetDeepMito_Predicted ($sorted_deepmito2[$k]);
    printf STDERR "\t%f", GetDeepMito_Score ($sorted_deepmito2[$k]);
    printf STDERR "\n";
  }
}

##  Sanity check that both lists are of equal length
if (scalar (@sorted_deepmito1) != scalar (@sorted_deepmito2)) {
  printf STDERR "EE\tSize of the two lists are different!  %u vs %u\n", scalar (@sorted_deepmito1), scalar (@sorted_deepmito2);
  exit (1);
}


########################################
##  Process each rank
########################################

my @ranks = split /,/, $ranks_str_arg;

for (my $k = 0; $k < scalar (@ranks); $k++) {
  my %names_list = ();
  my $overlap_count = 0;

  ##  Force the rank to be no larger than the number of records
  if ($ranks[$k] > scalar (@sorted_deepmito1)) {
    $ranks[$k] = scalar (@sorted_deepmito1);
  }

  for (my $i = 0; $i < $ranks[$k]; $i++) {
    my $curr_name = GetDeepMito_Name ($sorted_deepmito1[$i]);
    my $curr_predicted = GetDeepMito_Predicted ($sorted_deepmito1[$i]);

    $names_list{$curr_name} = 1;
  }

  for (my $j = 0; $j < $ranks[$k]; $j++) {
    my $curr_name = GetDeepMito_Name ($sorted_deepmito2[$j]);

    if (defined ($names_list{$curr_name})) {
      $overlap_count++;
      if ($shownames_arg == 1) {
        printf STDERR "==\t%u\t%s\n", $ranks[$k], $curr_name;
      }
    }
  }

  my $protein1_out = $protein1_arg;
  my $protein2_out = $protein2_arg;

  if ($protein1_out eq "atp8") {
    $protein1_out = "Atp8p";
  }
  elsif ($protein1_out eq "atp9") {
    $protein1_out = "Atp9p";
  }
  elsif ($protein1_out eq "cox2") {
    $protein1_out = "Cox2p";
  }

  if ($protein2_out eq "atp8") {
    $protein2_out = "Atp8p";
  }
  elsif ($protein2_out eq "atp9") {
    $protein2_out = "Atp9p";
  }
  elsif ($protein2_out eq "cox2") {
    $protein2_out = "Cox2p";
  }

  printf STDOUT "%s-%s\t%u\t%u\t%f\n", $protein1_out, $protein2_out, $ranks[$k], $overlap_count, $overlap_count / $ranks[$k];
}



