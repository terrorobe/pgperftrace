#!/usr/bin/perl


use strict;
use warnings;


use Getopt::Long;
use Data::Dumper;


use PGBench::Types;
use PGBench::JobList;
use PGBench::BenchDirector;
use PGBench::Config;

use vars qw( $Config );

my %opt;


GetOptions(\%opt,
        'build-dir=s',
        'release=s',
        'configure-opts=s',
        'bench-root-dir=s',
) or pod2usage( -verbose => 0 );

my ( $mode ) = @ARGV;



if ( $mode eq 'job' ) {

    my $joblist = JobList->new();
    $joblist->add_job(
            release => $opt{'release'},
            config_opts => $opt{'configure-opts'},
            benchmarks => ['sysbench'], # FIXME 
            );

    my $director = BenchDirector->new(
            benchJobs => $joblist,
            );


    $director->start_run();
}

sub pod2usage {
        print "You failed!\n";
}
