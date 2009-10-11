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
            $database = $self->_createDatabase($job);
            print "Successfully started database. Sleeping\n";
            sleep(30);
        }

        my $benchtype = $job->benchmark;
        eval "require PGBench::Benchmark::$benchtype";
        my $benchmark = "PGBench::Benchmark::$benchtype"->new($job->benchmark_opts);

        use Data::Dumper;
        print "Preparing\n";
        $benchmark->prepare();
        print "Running\n";
        $benchmark->run();
        print Dumper $benchmark;
        $benchmark->cleanup();
    }
}

sub _createDatabase {
    my ($self, $job) = @_;

    my $database = Database->new(
            branch => $job->db_branch,
            configure_opts => $job->db_compile_config
            );

    $database->createInstance({
            pg_configuration => $job->db_run_config,
            });
    $database->startPostgres();

    return $database;
}

1;
