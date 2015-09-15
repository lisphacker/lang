#! /usr/bin/env perl

use strict;

my @bootstrap_counts = (50, 100, 200, 500, 1000, 2000);

foreach my $bootstrap_count (@bootstrap_counts) {
    print "$bootstrap_count\n";
}
