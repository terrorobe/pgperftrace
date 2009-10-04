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
# ./run_build --keepall --test <BRANCH>
# Needs some hacking up:
# *) Build target directroy
# *) return codes?
# *) configure via cmdline
# *) wipe config file alltogether?

    print "I would build ", $self->release, "\n";
}

1;

