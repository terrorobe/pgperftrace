#!/usr/bin/perl


use strict;
use warnings;

use Getopt::Long;
use Data::Dumper;

use Carp;


use PGBench::Types;

use PGBench::BenchJob;

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

if ( $mode eq 'build' ) {
    print "building!\n";

# FIXME: Huebscher?
    my %buildopts;
    @buildopts{'release', 'build_dir'} = @opt{'release', 'build-dir'};
    $buildopts{'configure_opts'} = $opt{'configure-opts'} if $opt{'configure-opts'};
    my $builder = Builder->new( %buildopts );

    $builder->buildrelease;
}

if ( $mode eq 'job' ) {

    my $job = BenchJob->new();
    $job->add_job(
            release => $opt{'release'},
            config_opts => $opt{'configure-opts'},
            benchmarks => 'sysbench', # FIXME 
            );

    print Dumper $job;
    my $director = BenchDirector->new(
            benchJobs => $job,
            bench_root_dir => $opt{'bench-root-dir'},
            );

    $director->start_run();


}

sub pod2usage {
        print "You failed!\n";
}
