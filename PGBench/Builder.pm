package Builder;

use Moose;
use Carp;

has 'release' => (is => 'ro', isa => 'Str');
has 'build_dir' => (is => 'ro', isa => 'Str');
has 'configure_opts' => (is => 'ro', isa => 'Str', default => 'spartaaa');

sub BUILD {
    my ($self, $params) = @_;
    croak "build-dir " . $self->build_dir, " already exists" if (-e $self->build_dir);
    croak "release must be of form... FIXME" unless ($self->release =~ m/(REL\d_\d|HEAD)/);
}


sub buildrelease {
    my $self = shift;
    my $command = "build_farm/run_build.pl --build-only --build-root " . '$FIXME->build_root' . " --build-target " . $self->build_dir . " " . $self->release;
    print "I would run $command\n";
#my $output = qx/$command/;
    my $rc = $? >> 8;
    if ( $rc != 0 ){
        croak "fail!";
    }

}

1;

