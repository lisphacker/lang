#!/usr/bin/perl

for (my $i = 0; $i < 10; $i++) {
    next if ($i < 6);
    print "$i\n";
}

