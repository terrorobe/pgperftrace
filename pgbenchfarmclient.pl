#!/usr/bin/perl

use strict;
use warnings;

use LWP;
use JSON;

use PGBench::Communicator;

use Data::Dumper;



while (1) {

    print "Doing next job\n";
    do_next_job();
    sleep 60;
}


sub do_next_job {

    my $foo = fetch_next_job();

}

sub fetch_next_job {
    my $communicator = Communicator->new;

    return $communicator->pull_data('/job/client/CLIENT/get_next_job');
}
