#!/usr/bin/env perl
#####################################################################
##  Access_IDs.pm
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
package Access_IDs;

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
our @EXPORT = qw (GetMethodFromName GetProteinFromName);

##  Directories where Perl modules are stored
use lib qw (. ../../Common/Perl/);


sub GetMethodFromName {
  my ($record) = @_;

  my $id = "";
  my $method = "";
  my $seed = "";
  my $protein = "";
  if ($record =~ /^(\d+)_(\d+)_(\d+)_(.+)$/) {
    $id = $1;
    $method = $2;
    $seed = $3;
    $protein = $4;
  }
  elsif ($record =~ /^(\d+)_(\d+)_(\d+)$/) {
    $id = $1;
    $method = $2;
    $seed = $3;
    $protein = "";
  }

  return ($method);
}


sub GetProteinFromName {
  my ($record) = @_;

  my $id = "";
  my $method = "";
  my $seed = "";
  my $protein = "";
  if ($record =~ /^(\d+)_(\d+)_(\d+)_(.+)$/) {
    $id = $1;
    $method = $2;
    $seed = $3;
    $protein = $4;
  }
  elsif ($record =~ /^(\d+)_(\d+)_(\d+)$/) {
    $id = $1;
    $method = $2;
    $seed = $3;
    $protein = "";
  }

  return ($protein);
}


