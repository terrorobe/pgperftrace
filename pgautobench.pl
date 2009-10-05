#!/usr/bin/perl


use strict;
use warnings;

use Getopt::Long;
use Data::Dumper;

use PGBench::Types;
use PGBench::JobList;
use PGBench::Builder;
use PGBench::BenchDirector;


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

    use Data::Dumper;
    print Dumper $joblist;

    my $director = BenchDirector->new(
            benchJobs => $joblist,
            bench_root_dir => $opt{'bench-root-dir'},
            );


    $director->start_run();
}

sub pod2usage {
        print "You failed!\n";
}
