package DatabaseInstance;

use Moose;

has 'port' => (is => 'ro', isa => 'Num', required => 1);
has 'binpath' => (is => 'ro', isa => 'ExistingDir', required => 1);
has 'datapath' => (is => 'ro', isa => 'NonExistingDir', required => 1);
has 'pg_configuration' => (is => 'ro', isa => 'HashRef[Str]');
has 'initdb_options' => (is => 'ro', isa => 'Str');


sub BUILD {
   my ($self, $params) = @_;

    $self->_checkBinaries();
    $self->_createCluster();
}


sub _checkBinaries {
    my $self = shift;

    for my $bin (qw(initdb pg_ctl postmaster)) {
        $bin = $self->binpath . $bin;
        confess "Couldn't find $bin or not executable" unless (-x $bin);
    }
}

sub _createCluster {
    my $self = shift;

    my $command = $self->binpath . "initdb --pgdata " . $self->datapath;
    my $ouptut = qx/$command/;
    print "I baked you a cluster with $command\n";
}

1;
