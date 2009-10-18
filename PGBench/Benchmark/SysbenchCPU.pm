package PGBench::Benchmark::SysbenchCPU;

use Moose;

use PGBench::Result::SysbenchCPU;

with 'PGBench::Benchmark::Sysbench';

has 'max_prime' => (is => 'ro', isa => 'Num', required => 1, default => 10000);

sub BUILD {
    my ($self, $params) = @_;

    $self->bench_args($self->bench_args . ' --test=cpu'
            . ' --cpu-max-prime=' . $self->max_prime
            );
    $self->result(PGBench::Result::SysbenchCPU->new());
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
