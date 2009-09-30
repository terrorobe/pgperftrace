#!/usr/bin/perl

package Builder;
use Moose;
use Data::Dumper;
use Carp;

has 'release' => (is => 'rw', isa => 'Str');
has 'build_dir' => (is => 'rw', isa => 'Str');
has 'configure_opts' => (is => 'rw', isa => 'Str', default => 'spartaaa');

sub BUILD {
    my ($self, $params) = @_;
    croak "build-dir " . $self->build_dir, " already exists" if (-e $self->build_dir);
    croak "release must be of form... FIXME" unless ($self->release =~ m/(REL\d_\d|HEAD)/);
}


sub buildrelease {
    my $self = shift;
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
