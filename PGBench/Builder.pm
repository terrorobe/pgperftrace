package Builder;

use Moose;
use Carp;

has 'release' => (is => 'ro', isa => 'PgBranchName');
has 'build_dir' => (is => 'ro', isa => 'Str');
has 'buildfarm_dir' => (is => 'ro', isa => 'Str');
has 'configure_opts' => (is => 'ro', isa => 'Str', optional => 1);

sub BUILD {
    my ($self, $params) = @_;
    croak "build-dir " . $self->build_dir . " already exists" if (-e $self->build_dir);
    croak "buildfarm-dir " . $self->buildfarm_dir . " doesn't exist" unless (-d $self->buildfarm_dir);
}


sub buildrelease {
    my $self = shift;

    chdir('./build-farm');

    my $command = "./run_build.pl --build-only --build-root " . $self->buildfarm_dir . " --build-target " . $self->build_dir . " " . $self->release;
    print "I would run $command\n";
    my $output = qx/$command/;

    print "*******\n\n\n$output\n\n\n";
    my $rc = $? >> 8;
    if ( $rc != 0 ){
        croak "fail!";
    }

}

1;

