package PGBench::Benchmark::SysbenchCPU;

use Moose;

use PGBench::Result::SysbenchCPU;

with 'PGBench::Benchmark::Sysbench';

has 'max_prime' => (is => 'ro', isa => 'Num', required => 1, lazy_build => 1);

sub BUILD {
    my ($self, $params) = @_;

    use Data::Dumper;
    print Dumper $self;
    $self->bench_args($self->bench_args . ' --test=cpu'
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

sub run {
    my $self = shift;

    my $executor = Executor->new(confessOnError => 0);
    my $command = $self->sysbench . $self->bench_args;

    my $success = $executor->runCommand($command);
    $self->output(split /\n/, $output);
    $self->parseOutput();

    $self->result->successful_run($success);
}

sub parseOutput {
    my ($self, $output) = @_;

    my @lines = split /\n/, $output;



}

1;
