use strict;

my $queuename = undef;
#my $queuename = "batch";

#my $queueopt = defined($queuename) ? "-queue=$queuename" : "-queue=somethingelse";
my $queueopt = "-queue=$queuename" // "-queue=somethingelse";

print "[$queueopt]\n";
