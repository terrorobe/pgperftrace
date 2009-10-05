package DatabaseBuild;

use Moose;

use File::Path qw(rmtree);


has 'binpath' => (is => 'ro', isa => 'ExistingDir', required => 1);
has 'version' => (is => 'ro', isa => 'Str', optional => 1);

sub BUILD {
    my ($self, $params) = @_;

    my $command = "$binpath/postgres --version";
    my $version = qx/$command/;
    chomp $version;
    $self->version = $version;
    return;
}


sub DEMOLISH {
    my $self = shift;

    my $binpath = $self->binpath;

    print "Wiping out $binpath !\n";

#rmtree($binpath);
    return;
}

1;
