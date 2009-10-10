package BenchDirector;

use Moose;

use PGBench::BenchJob;
use PGBench::Database;

has 'benchJobs' => (is => 'ro', isa => 'JobList');


sub start_run {
    my $self = shift;

    for my $job (@{$self->benchJobs->jobs}) {

        my $database;

        if ( $job->db_branch ) {
            $database = Database->new(
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
#            sleep(30);
        }

        if (1) {

        my $benchtype = 'SysbenchCPU';
        require PGBench::Benchmark::SysbenchCPU;
        my $benchmark = Benchmark::SysbenchCPU->new({
                threads => 4,
                max_requests => 1000,
                });

        use Data::Dumper;
        print Dumper $benchmark;

        $benchmark->prepare();
        $benchmark->run();
        print Dumper $benchmark;
        $benchmark->cleanup();
        }

    }
}


1;
