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
        }


        require PGBench::Benchmark::sysbenchCPU;
        my $benchmark = Benchmark::sysbenchCPU->new({
                binpath => '/opt/sysbench/bin',
                threads => 4,
                });

        use Data::Dumper;
        print Dumper $benchmark;

        $benchmark->prepare();
        $benchmark->run();
        $benchmark->cleanup();

    }
}


1;
