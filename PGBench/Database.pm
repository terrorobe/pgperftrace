package Database;

use Moose;

use PGBench::Builder;
use PGBench::DatabaseInstance;

has 'release' => (is => 'ro', isa => 'PgBranchName', required => 1);
has 'configure_opts' => (is => 'ro', isa => 'Maybe[Str]');
has 'build' => (is => 'rw', isa => 'DatabaseBuild');
has 'instance' => (is => 'rw', isa => 'DatabaseInstance');

sub BUILD {

    my ($self, $params) = @_;

    _createBuild($self);

}


sub createInstance {
    my ($self, %opts) = @_;

    $opts{'build'} = $self->build;

    my $instance = DatabaseInstance->new(%opts);

    $self->instance($instance);
}

sub _createBuild {
    my $self = shift;

    my %build_opts = ( release => $self->release );

    $build_opts{'configure_opts'} = $self->configure_opts if ($self->configure_opts);

    my $build = Builder->new( %build_opts )->buildRelease();
    $self->build($build);
}

1;
