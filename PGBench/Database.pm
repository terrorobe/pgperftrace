package Database;

use Moose;



has 'release' => (is => 'ro', isa => 'PgBranchName', required => 1);
has 'configure_opts' => (is => 'ro', isa => 'Maybe[Str]');
has 'build' => (is => 'rw', isa => 'DatabaseBuild');
has 'instance' => (is => 'rw', isa => 'DatabaseInstance');

sub BUILD {

    my ($self, $params) = @_;

    $self->build = _build_release($self);

}

sub _build_release {

    my ($self) = @_;

    my %build_opts = ( release => $self->release );

    $build_opts{'configure_opts'} = $self->configure_opts if ($self->configure_opts);

    my $builder = Builder->new( %build_opts );

    $self->build = $builder->buildrelease();
}

1;
