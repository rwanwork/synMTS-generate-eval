#!/usr/bin/env perl
#####################################################################
##  parse-deepmito.pl
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

##  Include libraries for handling JSON files
use JSON;
use Data::Dumper;

##  Include library for reading in file
use File::Slurper 'read_text';

##  Directories where Perl modules are stored
use lib qw (. ../Common/Perl/ ../../Common/Perl/);


########################################
##  Important variables
########################################

##  Input arguments
my $input_fn_arg = "";

##  Keys in the JSON file (and the order we want them printed)
# my @keys = ( "accession", "mitochondrial_likelihood", "score", "alt_score", "second", "features", "sequence", "dbReferences", "comments" );
my @keys = ( "accession", "mitochondrial_likelihood", "score", "sequence", "dbReferences", "comments" );


########################################
##  Subroutines
########################################

sub PrintField {
  my ($key, $field) = @_;

  my $result = "";

  if (ref ($field) eq "HASH") {
    if ($key eq "sequence") {
      my %tmp = %{ $field };
#       $result = $tmp{sequence}."\t".$tmp{len};
      $result = $tmp{len};
    }
    else {
      printf STDERR "EE\tHash found but unexpected key!\n";
      exit (1);
    }
  }
  elsif (ref ($field) eq "ARRAY") {
    if ($key eq "features") {
      my @tmp = @{ $field };
      $result = $tmp[0];
    }
    elsif ($key eq "dbReferences") {
      my @tmp_array = @{ $field };
      my %tmp_hash = %{ $tmp_array[0] };

      my %tmp_hash2 = %{ $tmp_hash{properties} };
#        $result = $tmp_hash{type}."\t".$tmp_hash2{term}."\t".$tmp_hash{id};
       $result = $tmp_hash{id}."\t".$tmp_hash2{term};
    }
    elsif ($key eq "comments") {
      my @tmp_array = @{ $field };
      my %tmp_hash = %{ $tmp_array[0] };
      $result = $tmp_hash{type};
    }
    else {
      printf STDERR "EE\tArray found but unexpected structure!\n";
      exit (1);
    }
  }
  else {
    if ($key eq "accession") {
      my $id = 0;
      my $method = 0;
      my $seed = 0;
      my $protein = "";
      if ($field =~ /^(\d+)_(\d+)_(\d+)_(.+)$/) {
        $id = $1;
        $method = $2;
        $seed = $3;
        $protein = $4;
      }

      $result = $field."\t".$id."\t".$method."\t".$seed."\t".$protein;
    }
    else {
      $result = $field;
    }
  }

  return ($result);
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
});                        ##  Debug mode -- dump on JSON
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
##  Decode the file and place it in an array
########################################

my $decoded = decode_json ($text);
if ($config -> get ("debug")) {
  print  Dumper ($decoded);
}

my @decoded_array = @{ $decoded };

printf STDERR "==\tNumber of records:  %u\n", scalar (@decoded_array);


########################################
##  Print out each row
########################################

for (my $k = 0; $k < scalar (@decoded_array); $k++) {
  my %tmp_hash = %{ $decoded_array[$k] };

  my $str = PrintField ($keys[0], $tmp_hash{$keys[0]});
  printf STDOUT "%s", $str;
  for (my $j = 1; $j < scalar (@keys); $j++) {
    $str = PrintField ($keys[$j], $tmp_hash{$keys[$j]});
    if (!defined ($str)) {
      printf STDERR "%u\t%u\n", $k, $j;
      exit (1);
    }
    printf STDOUT "\t%s", $str;
  }
  printf STDOUT "\n";
}


