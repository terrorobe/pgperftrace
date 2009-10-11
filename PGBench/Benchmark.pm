package PGBench::Benchmark;

use Moose::Role;
use DateTime;

has 'options' => (is => 'ro', isa => 'HashRef[Str]', required => 1, default => sub { {} });
has 'version' => (is => 'ro', isa => 'Str', required => 1, lazy_build => 1);
has 'binpath' => (is => 'ro', isa => 'ExistingDir', required => 1, lazy_build => 1);
has 'result' => (is => 'rw', isa => 'Object');
has 'prepared' => (is => 'rw', isa => 'Bool', default => 0);

after 'prepare' => sub {
    my $self = shift;
    $self->prepared(1);
};

before 'run' => sub {
    my $self = shift;
    confess "Not prepared!" unless ($self->prepared);
    $self->result->start_time(DateTime->now);
};

after 'run' => sub {
    my $self = shift;
    $self->result->end_time(DateTime->now);
};

before 'parseOutput' => sub {
    my $self = shift;
    confess "Not (successul) run!" unless ($self->result->successful_run);
};

after 'cleanup' => sub {
    my $self = shift;
    $self->prepared(0);
};

sub prepare {
    confess "Prepare routine empty";
}

sub cleanup {
    confess "Cleanup routine empty";
}

sub run {
    confess "Run routine empty";
}

sub parseOutput {
    confess "Output parsing routine empty";
}

sub DEMOLISH {
    my $self = shift;
    $self->cleanup() if ($self->prepared);
}


1;
