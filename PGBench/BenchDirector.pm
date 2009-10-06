package BenchDirector;

use Moose;

use PGBench::BenchJob;
use PGBench::Database;

has 'benchJobs' => (is => 'ro', isa => 'JobList');


sub start_run {
    my $self = shift;

    for my $job (@{$self->benchJobs->jobs}) {

        my $database = Database->new(
                release => $job->release,
                configure_opts => $job->config_opts
                );

    }
}


1;
