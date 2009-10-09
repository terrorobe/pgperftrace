package Benchmark::sysbenchCPU;

use Moose;

with 'PGBench::Benchmark::sysbench';

has 'max_prime' => (is => 'ro', isa => 'Num', required => 1, lazy_build => 1);

sub BUILD {
    my ($self, $params) = @_;

    $self->bench_args($self->bench_args . ' --test=cpu'
            . ' --cpu-max-prime=' . $self->max_prime
            . ' run'
            );
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

sub run {
    my $self = shift;

    my $executor = Executor->new();
    my $command = $self->sysbench . $self->bench_args;

    $executor->runCommand($command);

    print "Output:\n\n" . $executor->output;

}

1;
