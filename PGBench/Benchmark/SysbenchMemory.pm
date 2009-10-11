package PGBench::Benchmark::SysbenchMemory;

use Moose;

use PGBench::Result::SysbenchMemory;

with 'PGBench::Benchmark::Sysbench';

has 'max_prime' => (is => 'ro', isa => 'Num', required => 1, lazy_build => 1);

sub BUILD {
    my ($self, $params) = @_;

    $self->bench_args($self->bench_args . ' --test=memory'
            . ' --cpu-max-prime=' . $self->max_prime
            . ' run'
            );
    $self->result(PGBench::Result::SysbenchCPU->new());
}

sub _build_max_prime {
    my $self = shift;

    return $self->options->{'max_prime'} ? $self->options->{'max_prime'} : 10000;
}

sub prepare {
    return;
}

sub cleanup {
    return;
}

sub parseOutput {
    return;
}

1;
