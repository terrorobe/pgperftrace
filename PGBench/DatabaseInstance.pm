package DatabaseInstance;

use Moose;

has 'port' => (is => 'ro', isa => 'Num', required => 1);
has 'build' => (is => 'ro', isa => 'DatabaseBuild', required => 1);
has 'datapath' => (is => 'ro', isa => 'NonExistingDir', required => 1);
has 'running' => (is => 'ro', isa => 'Bool');
has 'pg_configuration' => (is => 'ro', isa => 'HashRef[Str]');
has 'initdb_options' => (is => 'ro', isa => 'Str');


sub BUILD {
   my ($self, $params) = @_;

    $self->_createCluster();
    $self->_createConfig();
}


sub _createCluster {
    my $self = shift;

    my $command = $self->build->binpath . "initdb --pgdata " . $self->datapath;
    my $ouptut = qx/$command/;
    print "I baked you a cluster with $command\n";
}


sub _createConfig {
    my $self = shift;

}


sub startPostgres {
    my $self = shift;

}

1;
