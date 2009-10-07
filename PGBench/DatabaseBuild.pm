package DatabaseBuild;

use Moose;

use File::Path qw(rmtree);


has 'binpath' => (is => 'ro', isa => 'ExistingDir', required => 1);
has 'version' => (is => 'ro', isa => 'Str', required => 1, lazy_build => 1);
has 'delete_build' => (is => 'ro', isa => 'Bool', required => 1, default => 0);

sub BUILD {
   my ($self, $params) = @_;

    $self->_checkBinaries();

}

sub _build_version {
    my $self = shift;
    my $command = $self->binpath . "/bin/postgres --version";
    my $version = qx/$command/;
    return chomp $version;
}

sub _checkBinaries {
    my $self = shift;

    for my $bin (qw(initdb pg_ctl postmaster)) {
        $bin = $self->binpath . $bin;
        confess "Couldn't find $bin or not executable" unless (-x $bin);
    }
}


sub DEMOLISH {
    my $self = shift;

    my $binpath = $self->binpath;

    if ($self->delete_build) {
        print "Wiping out $binpath !\n";
        rmtree($binpath);
    }
    else {
        print "Keeping $binpath !\n";
    }
    return;
}

1;
