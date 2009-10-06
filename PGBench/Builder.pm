package Builder;

use Moose;

use PGBench::DatabaseBuild;

has 'release' => (is => 'ro', isa => 'PgBranchName', required => 1);
has 'configure_opts' => (is => 'ro', isa => 'Str');
has 'build_dir' => (is => 'ro', isa => 'NonExistingDir', required => 1,
        lazy => 1, default => sub {
        my $self = shift;
        return $Config::opt{'bench_root_dir'} . '/built_pg/' . $self->{'release'}
        }
        );
has 'buildfarm_dir' => (is => 'ro', isa => 'ExistingDir', required => 1,
        lazy => 1, default => sub {
        return $Config::opt{'bench_root_dir'} . '/build_farm/' 
        }
        );

sub buildrelease {
    my $self = shift;

# FIXME: Directory handling
    chdir('./build-farm');

    my $command = "./run_build.pl --build-only --build-root "
        . $self->buildfarm_dir . " --build-target " . $self->build_dir
        . " " . $self->release;
    $command .= "--configure-opts='" . $self->configure_opts . "'"
        if $self->configure_opts;

    print "I would run $command\n";
    my $output = qx/$command/;

    print "*******\n\n\n$output\n\n\n";
    my $rc = $? >> 8;
    if ( $rc != 0 ){
        confess "fail!";
    }

    return DatabaseBuild->new(binpath => $self->build_dir);
}

1;
