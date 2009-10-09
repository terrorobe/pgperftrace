package Benchmark;

use Moose::role;

has 'options' => (is => 'ro', isa => 'HashRef[Str]', required => 1);
has 'result' => (is => 'rw', isa => 'HashRef[Str]');

sub prepare {
    confess "Prepare routine empty";
}

sub cleanup {
    confess "Cleanup routine empty";
}

sub run {
    confess "Run routine empty";
}



1;
