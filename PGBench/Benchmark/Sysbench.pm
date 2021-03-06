package PGBench::Benchmark::Sysbench;

use Moose::Role;
use File::Which;
use File::Basename;
use Try::Tiny;

use PGBench::Executor;

with 'PGBench::Benchmark';

has 'sysbench' => (is => 'ro', isa => 'ExecutableFile', required => 1, lazy_build => 1);
has 'threads' => (is => 'ro', isa => 'Num', required => 1, default => 1);
has 'max_requests' => (is => 'ro', isa => 'Num', required => 1, default => 10000);
has 'max_time' => (is => 'ro', isa => 'Num', required => 1, default => 0);
has 'bench_args' => (is => 'rw', isa => 'Str', required => 1, lazy_build => 1);
has 'output' => (is => 'rw', isa => 'ArrayRef[Str]');

before 'parseOutput' => sub {
    my $self = shift;
    $self->parseOutputSysbenchGeneric();
};

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

sub _build_binpath {
    my $self = shift;

    return $Config::opt{'sysbench_dir'} if ($Config::opt{'sysbench_dir'});

    my $executable = which('sysbench');

    confess "Couldn't find sysbench executable" unless ($executable);

    return dirname($executable);
}

sub _build_sysbench {
    my $self = shift;

# FIXME: Find sysbench in path?
    my $command = $self->binpath . '/' if ($self->binpath);
    $command .= 'sysbench';

    return $command;
}

sub run {
    my $self = shift;

    my %opts;
    $opts{'confessOnError'} = 0;

# FIXME: workdir only exists for filetests here...
    try {
        if ($self->workdir) {
            $opts{'changeWD'} = $self->workdir;
        }
    };


    my $executor = Executor->new(%opts);
    my $command = $self->sysbench . $self->bench_args . ' run';

    my $success = $executor->runCommand($command);
    $self->output([ split /\n/, $executor->output ]);
    $self->result->successful_run($success);

    $self->parseOutput();
}

sub parseOutputSysbenchGeneric {
    my $self = shift;

    for my $line (@{$self->output}) {

        if ($line =~ m/\s+total time:\s+([.\d]+)s/) {
            $self->result->total_time($1);
        }

        elsif ($line =~ m/\s+total number of events:\s+(\d+)/) {
            $self->result->total_num_events($1);
        }

        elsif ($line =~ m/\s+min:\s+([.\d]+)ms/) {
            $self->result->per_req_min_dur($1);
        }

        elsif ($line =~ m/\s+avg:\s+([.\d]+)ms/) {
            $self->result->per_req_avg_dur($1);
        }

        elsif ($line =~ m/\s+max:\s+([.\d]+)ms/) {
            $self->result->per_req_max_dur($1);
        }

        elsif ($line =~ m/\s+approx\.\s+95 percentile:\s+([.\d]+)ms/) {
            $self->result->per_req_95p_dur($1);
        }

        elsif ($line =~ m/\s+events[^:]+:\s+([.\d]+)\/([.\d]+)/) {
            $self->result->per_thread_avg_events($1);
            $self->result->per_thread_avg_events_stddev($2);
        }

        elsif ($line =~ m/\s+execution time[^:]+:\s+([.\d]+)\/([.\d]+)/) {
            $self->result->per_thread_avg_time($1);
            $self->result->per_thread_avg_time_stddev($2);
        }
    }
}

1;
