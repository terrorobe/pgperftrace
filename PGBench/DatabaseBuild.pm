package DatabaseBuild;

use Moose;

use PGBench::Executor;

use File::Path qw(rmtree);


has 'buildpath' => (is => 'ro', isa => 'ExistingDir', required => 1);
has 'binpath' => (is => 'ro', isa => 'ExistingDir', lazy_build => 1);
has 'version' => (is => 'ro', isa => 'Str', required => 1, lazy_build => 1);
has 'delete_build' => (is => 'ro', isa => 'Bool', required => 1, default => 0);

sub BUILD {
   my ($self, $params) = @_;

    $self->_checkBinaries();
}

sub _build_version {
    my $self = shift;
    my $command = $self->binpath . "postgres --version";
    my $executor = Executor->new();
    $executor-> runCommand($command);
    if ($executor->rc) {
        confess "I failed you!\n";
    }
    chomp(my $output = $executor->output);
    return $output;
}

sub _build_binpath {
    my $self = shift;
    return $self->buildpath . '/bin/';
}

sub _checkBinaries {
    my $self = shift;

    for my $tool (qw(initdb pg_ctl postmaster)) {
        my $bin = $self->binpath . $tool;
        confess "Couldn't find $bin or not executable" unless (-x $bin);
    }
}


sub DEMOLISH {
    my $self = shift;

    my $buildpath = $self->buildpath;
# Skipping failed builds
    return unless (-d $buildpath);

    if ($self->delete_build) {
        print "Wiping out $buildpath !\n";
        rmtree($buildpath);
    }
    else {
        print "Keeping $buildpath !\n";
    }
    return;
}

1;
