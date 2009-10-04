package BenchDirector;

use Moose;
use Carp;

use PGBench::Builder;
use PGBench::BenchJob;

has 'benchJobs' => (is => 'ro', isa => 'PGBench::BenchJob');
has 'bench_root_dir' => (is => 'ro', isa => 'Str', default => '/srv/pgperftrace');

sub BUILD {
    my ($self, $params) = @_;
    croak "bench_root_dir " . $self->bench_root_dir . "doesn't exist" unless (-d $self->bench_root_dir);

} 

sub DEMOLISH {

# FIXME Wipe pg binary directories

}

sub start_run {
    my $self = shift;

    for my $job ($self->benchJobs->get_jobs()) {

        build_release($self, $job->{'release'}, $job->{'config_opts'});


    }
}


sub build_release {

    my ($self, $release, $config_opts) = @_;

    my $builder = Builder->new(
            release => $release,
            configure_opts => $config_opts,
            buildfarm_dir => $self->bench_root_dir . '/build_farm/',
            build_dir => $self->bench_root_dir . "/built_pg/$release",
            );

    $builder->buildrelease();
}

1;
