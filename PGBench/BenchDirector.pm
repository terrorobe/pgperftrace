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

        $database->createInstance(
                port => 54321,
                datapath => '/srv/raid0/lala',
                pg_configuration => ({
                    log_min_duration_statement => 42,
                    max_connections => 1234,
                    }
                    ),
                );

        use Data::Dumper;

        print $database->build->version . "\n";
        print Dumper $database;
        $database->instance->startPostgres();
        print "Successfully started database. Sleeping\n";
        sleep(60);
    }
}


1;
