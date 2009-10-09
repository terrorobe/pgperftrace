package PGBench::Benchmark::Sysbench;

use Moose::Role;

use PGBench::Executor;

with 'PGBench::Benchmark';

has 'sysbench' => (is => 'ro', isa => 'ExecutableFile', required => 1, lazy_build => 1);
has 'threads' => (is => 'ro', isa => 'Num', required => 1, lazy_build => 1);
has 'max_requests' => (is => 'ro', isa => 'Num', required => 1, lazy_build => 1);
has 'max_time' => (is => 'ro', isa => 'Num', required => 1, lazy_build => 1);
has 'bench_args' => (is => 'rw', isa => 'Str', required => 1, lazy_build => 1);


sub _build_threads {
    my $self = shift;

    return $self->options->{'threads'} ? $self->options->{'threads'} : 1;
}

sub _build_max_requests {
    my $self = shift;

    return $self->options->{'max_requests'} ? $self->options->{'max_requests'} : 10000;
}

sub _build_max_time {
    my $self = shift;

    return $self->options->{'max_time'} ? $self->options->{'max_time'} : 0;
}

sub _build_bench_args {
    my $self = shift;

    my $args = ' --num-threads=' . $self->threads .
        ' --max-requests=' . $self->max_requests .
        ' --max-time=' . $self->max_time;

    return $args;
}

sub _build_version {
    my $self = shift;

    my $executor = Executor->new();
    my $command = $self->sysbench . ' --version';
    $executor->runCommand($command);

    chomp(my $version = $executor->output);

    return $version;
}

sub _build_sysbench {
    my $self = shift;

    my $command = $self->binpath . '/' if ($self->binpath);
    $command .= 'sysbench';

    return $command;
}


1;
