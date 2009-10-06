package DatabaseBuild;

use Moose;

use File::Path qw(rmtree);


has 'binpath' => (is => 'ro', isa => 'ExistingDir', required => 1);
has 'version' => (is => 'ro', isa => 'Str', required => 1, lazy_build => 1);

sub _build_version {
    my $self = shift;
    my $command = $self->binpath . "/bin/postgres --version";
    my $version = qx/$command/;
    return chomp $version;
}


sub DEMOLISH {
    my $self = shift;

    my $binpath = $self->binpath;

    print "Wiping out $binpath !\n";

#rmtree($binpath);
    return;
}

1;
