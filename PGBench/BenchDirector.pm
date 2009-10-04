package BenchDirector;

use Moose;
use File::Path;

use PGBench::Builder;
use PGBench::BenchJob;

has 'benchJobs' => (is => 'ro', isa => 'BenchJob');
has 'bench_root_dir' => (is => 'ro', isa => 'ExistingDir', default => '/srv/pgperftrace');


sub DEMOLISH {

    my $self = shift;

    for my $job ($self->benchJobs->get_jobs()) {

# FIXME REFACTOR BENCHJOBS FFS!
        my $bindir = $self->bench_root_dir . '/built_pg/' . $job->{'$release'};

        print "Wiping out $bindir\n";
        remove_tree($bindir);
    }
}

sub start_run {
    my $self = shift;

    for my $job ($self->benchJobs->get_jobs()) {

        build_release($self, $job->{'release'}, $job->{'config_opts'});

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
