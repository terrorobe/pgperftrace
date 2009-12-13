#!/usr/bin/perl

use strict;
use warnings;

use LWP;
use JSON;

use PGBench::Communicator;

use Data::Dumper;


my $client = 'testclient';

my $ua = LWP::UserAgent->new;

while (1) {


    print "Fetching next job\n";

    my $stuff = fetch_next_job();

    print Dumper $stuff;

    sleep 60;


}


sub fetch_next_job {
    my $communicator = Communicator->new;

    return $communicator->pull_data('/job/client/CLIENT/get_next_job');
}
