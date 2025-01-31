#!/usr/bin/env perl
#####################################################################
##  rank-deepmito-mitofates.pl
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
use Sort_MitoFates;


########################################
##  Important variables
########################################

##  Input arguments
my $deepmito_fn_arg = "";
my $mitofates_fn_arg = "";
my $ranks_str_arg = "";
my $methods_str_arg = "";
my $shownames_arg = 0;
my $debug_arg = 0;

##  Data structures
my @deepmito;
my @mitofates;


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


##  Sort using explicit subroutine name on the probability
sub mitofates_cmpfn {
  my @x_array = split /\t/, $a;
  my $x = $x_array[1];

  my @y_array = split /\t/, $b;
  my $y = $y_array[1];

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
$config -> define ("mitofates", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  File of MitoFates' output
$config -> define ("ranks", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  List of comma separated ranks
$config -> define ("methods", {
  ARGCOUNT => AppConfig::ARGCOUNT_ONE,
  ARGS => "=s"
});                        ##  List of comma separated methods
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

if (!defined ($config -> get ("mitofates"))) {
  printf STDERR "EE\tMitoFates output required with the --mitofates option!\n";
  exit (1);
}
$mitofates_fn_arg = $config -> get ("mitofates");

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
printf STDERR "==\t  MitoFates filename:  %s\n", $mitofates_fn_arg;
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
##  Read in the DeepMito file
########################################

my $deepmito_count = 0;
open (my $deepmito_fp, "<", $deepmito_fn_arg) or die "EE\tCould not open $deepmito_fn_arg for input!\n";
my $header = <$deepmito_fp>;  ##  Discard the header
while (<$deepmito_fp>) {
  my $line = $_;
  chomp ($line);

  my @tmp_array = split /\t/, $line;

  ##  Name, predicted [yes/no], score
  my $record = $tmp_array[0]."\t".$tmp_array[5]."\t".$tmp_array[6];

  push (@deepmito, $record);
  $deepmito_count++;
}
close ($deepmito_fp);


########################################
##  Read in the MitoFates file
########################################

my $mitofates_count = 0;
open (my $mitofates_fp, "<", $mitofates_fn_arg) or die "EE\tCould not open $mitofates_fn_arg for input!\n";
$header = <$mitofates_fp>;  ##  Discard the header
while (<$mitofates_fp>) {
  my $line = $_;
  chomp ($line);

  my @tmp_array = split /\t/, $line;

  ##  Name, probability
  my $record = $tmp_array[0]."\t".$tmp_array[5];

  push (@mitofates, $record);
  $mitofates_count++;
}
close ($mitofates_fp);


########################################
##  Sort the two arrays
########################################

my @sorted_deepmito = sort deepmito_cmpfn @deepmito;
my @sorted_mitofates = sort mitofates_cmpfn @mitofates;


########################################
##  Debug mode; print the arrays out (long output!)
########################################

if ($debug_arg == 1) {
  for (my $k = 0; $k < scalar (@sorted_deepmito); $k++) {
    printf STDERR "%s", GetDeepMito_Name ($sorted_deepmito[$k]);
    printf STDERR "\t%s", GetDeepMito_Predicted ($sorted_deepmito[$k]);
    printf STDERR "\t%f", GetDeepMito_Score ($sorted_deepmito[$k]);
    printf STDERR "\n";
  }

  for (my $k = 0; $k < scalar (@sorted_mitofates); $k++) {
    printf STDERR "%s", GetMitoFates_Name ($sorted_mitofates[$k]);
    printf STDERR "\t%f", GetMitoFates_Probability ($sorted_mitofates[$k]);
    printf STDERR "\n";
  }
}

##  Sanity check that both lists are of equal length
if (scalar (@sorted_deepmito) != scalar (@sorted_mitofates)) {
  printf STDERR "EE\tSize of the two lists are different!  %u vs %u\n", scalar (@sorted_deepmito), scalar (@sorted_mitofates);
  exit (1);
}


########################################
##  Process each rank
########################################

my @ranks = split /,/, $ranks_str_arg;
my @methods = split /,/, $methods_str_arg;

for (my $k = 0; $k < scalar (@ranks); $k++) {
  my %names_list = ();
  my $overlap_count = 0;
  my %methods_count = ();

  ##  Force the rank to be no larger than the number of records
  if ($ranks[$k] > scalar (@sorted_deepmito)) {
    $ranks[$k] = scalar (@sorted_deepmito);
  }

  ##  Initialise the methods count
  for (my $m = 0; $m < scalar (@methods); $m++) {
    $methods_count{$methods[$m]} = 0;
  }

  for (my $i = 0; $i < $ranks[$k]; $i++) {
    my $curr_name = GetDeepMito_Name ($sorted_deepmito[$i]);
    my $curr_predicted = GetDeepMito_Predicted ($sorted_deepmito[$i]);

    if ($curr_predicted eq "Yes") {
      $names_list{$curr_name} = 1;
    }
  }

  for (my $j = 0; $j < $ranks[$k]; $j++) {
    my $curr_name = GetMitoFates_Name ($sorted_mitofates[$j]);

    if (defined ($names_list{$curr_name})) {
      $overlap_count++;
      if ($shownames_arg == 1) {
        printf STDERR "==\t%u\t%s\n", $ranks[$k], $curr_name;
      }

      my $curr_method = GetMethodFromName ($curr_name);
      if (defined ($methods_count{$curr_method})) {
        $methods_count{$curr_method}++;
      }
      else {
        printf STDERR "EE\tCould not determine method from:  %s\n", $curr_name;
        exit (1);
      }
    }
  }

  printf STDOUT "%u\tAll\t%u\n", $overlap_count;
  foreach my $key (sort (keys %methods_count)) {
    printf STDOUT "%u\t%u\t%u\n", $ranks[$k], $key, $methods_count{$key};
  }
}



