package DatabaseInstance;

use Moose;

use PGBench::Executor;

use File::Path qw(rmtree);
use File::Copy;
use File::Slurp;

has 'port' => (is => 'ro', isa => 'Num', required => 1);
has 'build' => (is => 'ro', isa => 'DatabaseBuild', required => 1);
has 'datapath' => (is => 'ro', isa => 'NonExistingDir', required => 1);
has 'running' => (is => 'ro', isa => 'Bool');
has 'pg_configuration' => (is => 'ro', isa => 'HashRef[Str]');
has 'initdb_options' => (is => 'ro', isa => 'Str');


sub BUILD {
   my ($self, $params) = @_;

    $self->pg_configuration->{'port'} = $self->port;

    $self->_createCluster();
    $self->_createConfig();
}


sub _createCluster {
    my $self = shift;

    my $executor = Executor->new();

    my $command = $self->build->binpath . "initdb --pgdata " . $self->datapath;
    $executor->runCommand($command);

    if ($executor->rc) {
        print $executor->output . "\n";
        confess "I failed you!";
    }

    print "I baked you a cluster with $command\n";
}


sub _createConfig {
    my $self = shift;

    my $configfile = $self->datapath . '/postgresql.conf';
    my %generatedConfig;


    if (-e $configfile && ! -e "$configfile.in" ) {
            move($configfile, "$configfile.in") or confess "Failed to move configfile";
    }
    else {
        confess "Funky state of cluster!";
    }

    my @lines = read_file("$configfile.in") or confess "Failed to read configfile";


    my $PgConfigLineRE = qr/
        ^\s*        # Leading whitespace
        ([^\s=]+)   # Key
        \s*=\s*     # '='
        ([^#]+)   # Value
        /x;
    

    for my $line (@lines) {

# Skip empty or comment-only lines
        next if ($line =~ m/^\s*#/);
        
        if ($line =~ m/$PgConfigLineRE/) {

            my ($key, $value) = ($1, $2);

# Trim trailing whitespace, for good measure
            $value =~ s/\s+$//;

            $generatedConfig{$key} = $value;
        }
    }

# Merging existing and supplied configuration, overriding shipped values if necessary
    %generatedConfig = (%generatedConfig, %{$self->pg_configuration});

    my @write_config;

    for my $key (keys %generatedConfig) {
        push @write_config, "$key = " . $generatedConfig{$key} . "\n";
    }

    write_file $configfile, @write_config or confess "Failed to write config";

    return;
}


sub startPostgres {
    my $self = shift;

}

sub stopPostgres {
    my $self = shift;


}

sub DESTROY {
    my $self = shift;
    $self->stopPostgres() if ($self->running);

    if ($self->datapath && -d $self->datapath) {
        print "wiping " . $self->datapath . "\n";
#        rmtree($self->datapath);
    }
}

1;
