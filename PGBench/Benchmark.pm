package PGBench::Benchmark;

use Moose::Role;

has 'options' => (is => 'ro', isa => 'HashRef[Str]', required => 1, default => sub { {} });
has 'version' => (is => 'ro', isa => 'Str', required => 1, lazy_build => 1);
has 'binpath' => (is => 'ro', isa => 'ExistingDir', required => 1, lazy_build => 1);
has 'result' => (is => 'rw', isa => 'Any'); #FIXME: WTF?

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
