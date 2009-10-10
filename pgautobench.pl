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
        'release=s',
        'configure-opts=s',
        'bench-root-dir=s',
) or pod2usage( -verbose => 0 );

my ( $mode ) = @ARGV;



if ( $mode eq 'job' ) {

    my $joblist = JobList->new();
    $joblist->add_job(
            db_branch => $opt{'release'},
            db_compile_config => $opt{'configure-opts'},
            db_run_config => {
                log_min_duration_statement => 42,
                },
            benchmark => 'SysbenchCPU',
            benchmark_opts => {
                threads => 10,
                max_requests => 1000,
                max_prime => 10000,
                },
 
            );

    my $director = BenchDirector->new(
            benchJobs => $joblist,
            );


    $director->start_run();
}

sub pod2usage {
        print "You failed!\n";
}
