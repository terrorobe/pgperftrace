package BenchDirector;

use Moose;

use PGBench::BenchJob;
use PGBench::Database;

has 'benchJobs' => (is => 'ro', isa => 'JobList');


sub start_run {
    my $self = shift;

    for my $job (@{$self->benchJobs->jobs}) {

        my $database = Database->new(
                branch => $job->db_branch,
                configure_opts => $job->db_config
                );

        $database->createInstance(
                pg_configuration => ({
                    log_min_duration_statement => 42,
                    max_connections => 1234,
                    shared_buffers => 8 * 1024,
                    }
                    ),
                );


        $database->startPostgres();
        print "Successfully started database. Sleeping\n";
        sleep(60);
    }
}


1;
