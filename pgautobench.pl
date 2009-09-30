#!/usr/bin/perl

package Builder;
use Moose;
use Data::Dumper;
has 'release' => (is => 'rw', isa => 'Str');
has 'target' => (is => 'rw', isa => 'Str');
has 'configure-opts' => (is => 'rw', isa => 'Str', default => 'spartaaa');

sub BUILD {
    my ($self, $params) = @_;
# FIXME: Option validation goes here...
}


sub buildrelease {
    my $self = shift;
    print Dumper $self;
    print "I would build ", $self->release, "\n";
}

1;


package main;

use strict;
use warnings;

use Getopt::Long;
use Data::Dumper;

use Carp;


my %opt;

GetOptions(\%opt,
        'target:s',
        'release:s',
        'configure-opts:s'
) or pod2usage( -verbose => 0 );

my ( $mode ) = @ARGV;

if ( $mode eq 'build' ) {
    print "building!\n";

# FIXME: Huebscher?
    my %buildopts;
    @buildopts{'release', 'target'} = @opt{'release', 'target'};
    $buildopts{'configure-opts'} = $opt{'configure-opts'} if $opt{'configure-opts'};
    my $builder = Builder->new( %buildopts );

    $builder->buildrelease;
}

sub pod2usage {
        print "You failed!\n";
}

1;
