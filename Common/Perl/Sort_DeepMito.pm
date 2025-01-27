#!/usr/bin/env perl
#####################################################################
##  Sort_DeepMito.pm
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


##  Define the namespace
package Sort_DeepMito;

use FindBin qw ($Bin);
use lib $FindBin::Bin;  ##  Search the directory where the script is located

##  Employ strict, warnings, and diagnostics
use strict;
use warnings;
use diagnostics;

##  Define this module's version
our $VERSION = '1.00';

##  Inherit from the Exporter module
use base 'Exporter';

##  Set of subroutines to be exported
our @EXPORT = qw (GetDeepMito_Name GetDeepMito_Predicted GetDeepMito_Score);

##  Directories where Perl modules are stored
use lib qw (. ../../Common/Perl/);


sub GetDeepMito_Name {
  my ($record) = @_;

  my @tmp_array = split /\t/, $record;

  my $protein_name = $tmp_array[0];

  my $id = "";
  my $method = "";
  my $seed = "";
  my $protein = "";
  if ($protein_name =~ /^(\d+)_(\d+)_(\d+)_(.+)$/) {
    $id = $1;
    $method = $2;
    $seed = $3;
    $protein = $4;
  }
  my $mts_name = $id."_".$method."_".$seed;

  return ($mts_name);
}


sub GetDeepMito_Predicted {
  my ($record) = @_;

  my @tmp_array = split /\t/, $record;
  return ($tmp_array[1]);
}


sub GetDeepMito_Score {
  my ($record) = @_;

  my @tmp_array = split /\t/, $record;
  return ($tmp_array[2]);
}


