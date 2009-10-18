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
    if (1) {
    $joblist->add_job(
            db_branch => $opt{'release'},
            db_compile_config => $opt{'configure-opts'},
            db_run_config => {
                log_min_duration_statement => 42,
                },
            benchmark => 'SysbenchCPU',
            benchmark_opts => {
                threads => 10,
                max_requests => 2000,
                max_prime => 11000,
                },
 
            );
    $joblist->add_job(
            benchmark => 'SysbenchMemory',
            benchmark_opts => {
                max_time => 5,
                },
            );
    }

    $joblist->add_job(
            benchmark => 'SysbenchFileIO',
            benchmark_opts => {
                test_mode => 'rndrd',
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
