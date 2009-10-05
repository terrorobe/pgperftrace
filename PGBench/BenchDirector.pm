package BenchDirector;

use Moose;

use PGBench::Builder;
use PGBench::BenchJob;

has 'benchJobs' => (is => 'ro', isa => 'JobList');
has 'bench_root_dir' => (is => 'ro', isa => 'ExistingDir', default => '/srv/pgperftrace');


sub start_run {
    my $self = shift;

    use Data::Dumper;
    print Dumper $self;
    for my $job (@{$self->benchJobs->jobs}) {

        print Dumper $job;
        build_release($self, $job->release, $job->config_opts);

    }
}


sub build_release {

    my ($self, $release, $config_opts) = @_;

    my %build_opts = (
            release => $release,
            buildfarm_dir => $self->bench_root_dir . '/build_farm/',
            build_dir => $self->bench_root_dir . "/built_pg/$release",
            );

    $build_opts{'configure_opts'} = $config_opts if ($config_opts);

    my $builder = Builder->new( %build_opts );

    $builder->buildrelease();
}

1;
