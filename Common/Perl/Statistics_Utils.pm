#!/usr/bin/env perl
#####################################################################
##  Statistics_Utils.pm
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
package Statistics_Utils;

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
our @EXPORT = qw (SumStats AvgStats CalculateStats);

##  Directories where Perl modules are stored
use lib qw (. ../../Common/Perl/);


########################################
##  Various methods
########################################

sub SumStats {
  my ($aa_ref, $seq, $method) = @_;

  my %aa_hash = %{ $aa_ref };
  my $sum = 0;

  my @tmp = split //, $seq;
  my $length = scalar (@tmp);

  for (my $k = 0; $k < $length; $k++) {
    if (!defined ($aa_hash{$tmp[$k]}{$method})) {
      printf STDERR "%s %s\n", $tmp[$k], $method;
    }
    $sum += $aa_hash{$tmp[$k]}{$method};
  }

  return ($sum);
}


sub AvgStats {
  my ($aa_ref, $seq, $method) = @_;

  my %aa_hash = %{ $aa_ref };
  my $sum = 0;

  my @tmp = split //, $seq;
  my $length = scalar (@tmp);

  for (my $k = 0; $k < $length; $k++) {
    if (!defined ($aa_hash{$tmp[$k]}{$method})) {
      printf STDERR "%s %s\n", $tmp[$k], $method;
    }
    $sum += $aa_hash{$tmp[$k]}{$method};
  }

  return ($sum / $length);
}


sub CalculateStats {
  my ($aa_ref, $id, $seq) = @_;
  my $stats_str = "";

  my %aa_hash = %{ $aa_ref };

  my $charge_sum = SumStats (\%aa_hash, $seq, "charge");
  my $flexibility_sum = SumStats (\%aa_hash, $seq, "flexibility");
  my $transmembrane_sum = SumStats (\%aa_hash, $seq, "transmembrane");
  my $hydropathicity_sum = SumStats (\%aa_hash, $seq, "hydropathicity");
  my $polarity_sum = SumStats (\%aa_hash, $seq, "polarity");
  my $bulkiness_sum = SumStats (\%aa_hash, $seq, "bulkiness");

  my $charge_avg = AvgStats (\%aa_hash, $seq, "charge");
  my $flexibility_avg = AvgStats (\%aa_hash, $seq, "flexibility");
  my $transmembrane_avg = AvgStats (\%aa_hash, $seq, "transmembrane");
  my $hydropathicity_avg = AvgStats (\%aa_hash, $seq, "hydropathicity");
  my $polarity_avg = AvgStats (\%aa_hash, $seq, "polarity");
  my $bulkiness_avg = AvgStats (\%aa_hash, $seq, "bulkiness");

  $stats_str = $id."\t".length ($seq);
  $stats_str = $stats_str."\t".sprintf ("%.3f\t%.3f", $charge_sum, $charge_avg);
  $stats_str = $stats_str."\t".sprintf ("%.3f\t%.3f", $flexibility_sum, $flexibility_avg);
  $stats_str = $stats_str."\t".sprintf ("%.3f\t%.3f", $transmembrane_sum, $transmembrane_avg);
  $stats_str = $stats_str."\t".sprintf ("%.3f\t%.3f", $hydropathicity_sum, $hydropathicity_avg);
  $stats_str = $stats_str."\t".sprintf ("%.3f\t%.3f", $polarity_sum, $polarity_avg);
  $stats_str = $stats_str."\t".sprintf ("%.3f\t%.3f", $bulkiness_sum, $bulkiness_avg);

  return ($stats_str);
}


