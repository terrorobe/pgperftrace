package Builder;

use Moose;

use PGBench::DatabaseBuild;
use PGBench::Executor;
use File::Path qw(rmtree);
use Digest::MD5 qw(md5_hex);

has 'release' => (is => 'ro', isa => 'PgBranchName', required => 1);
has 'configure_opts' => (is => 'ro', isa => 'Str', default => '');
has 'freshness' => (is => 'ro', isa => 'Num', required => 1, default => 86400);
has 'build_dir' => (is => 'ro', isa => 'Str', required => 1, lazy_build => 1);
has 'buildfarm_dir' => (is => 'ro', isa => 'ExistingWritableDir', required => 1, lazy_build => 1);


sub _build_build_dir {
    my $self = shift;

    my $dirname = $Config::opt{'bench_root_dir'} . '/built_pg/'
        . $self->{'release'};

    if ($self->configure_opts) {
        my $dir_suffix = md5_hex($self->configure_opts);

        # Why, yes, I'm an optimist. And aesthet.
        $dir_suffix = substr $dir_suffix, 0, 8;
        my $dirname .= "-$dir_suffix";
    }

    return $dirname;
}

sub _build_buildfarm_dir {
    return $Config::opt{'bench_root_dir'} . '/build_farm/';
}

sub buildRelease {
    my $self = shift;
    my $postmaster = $self->build_dir . '/bin/postmaster';

    if (-d $self->build_dir) {
        if (-e $postmaster ) {
            my $postmaster_age = time - ( stat($postmaster) )[9];
            if ( $postmaster_age <= $self->freshness ) {
                print "Using existing build, only $postmaster_age seconds old!\n";
                return DatabaseBuild->new(buildpath => $self->build_dir);
            }
            print "Wiping out stale build_dir: " . $self->build_dir . "\n";
            rmtree($self->build_dir);
        }
    }

    confess "Don't know what to do about " . $self->build_dir if (-e $self->build_dir);

    $self->_doBuild();

    return DatabaseBuild->new(buildpath => $self->build_dir);
}


sub _doBuild {
    my $self = shift;

    my $command = "./run_build.pl --build-only --build-root "
        . $self->buildfarm_dir . " --build-target " . $self->build_dir
        . " " . $self->release;
    $command .= " --config-opts='" . $self->configure_opts . "'"
        if $self->configure_opts;

    my $executor = Executor->new(changeWD => './build-farm');
    $executor->runCommand($command);

    if ($executor->rc) {
        print $executor->output . "\n";
        confess "I failed you!";
    }
}

1;
