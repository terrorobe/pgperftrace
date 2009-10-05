package JobList;

use Moose;

use PGBench::BenchJob;

# FIXME: Type check not working?
has 'jobs' => (is => 'rw', isa => 'ArrayRef[BenchJob]', default => sub { [] });

sub add_job {
    my ($self, %job_opts) = @_;

    my $job = BenchJob->new(%job_opts);

    push @{$self->jobs}, $job;
    return;
}

1;
