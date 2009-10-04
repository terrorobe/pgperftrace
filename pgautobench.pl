#!/usr/bin/perl



package main;

use strict;
use warnings;

use Getopt::Long;
use Data::Dumper;

use Carp;


my %opt;

GetOptions(\%opt,
        'build-dir:s',
        'release:s',
        'configure-opts:s'
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

sub pod2usage {
        print "You failed!\n";
}

1;
