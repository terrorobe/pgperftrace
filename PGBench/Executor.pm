package Executor;

use Moose;
use Cwd;

has 'verbose' => (is => 'ro', isa => 'Bool', default => 1);
has 'rc' => (is => 'rw', isa => 'Num');
has 'output' => (is => 'rw', isa => 'Str');
has 'changeWD' => (is => 'ro', isa => 'ExistingDir');


sub runCommand {
    my $self = shift;
    my $command = shift;

    my ($rc, $output) = $self->_execute($command);

    $self->rc($rc);
    $self->output($output);

    return $rc == 0;
}


sub runBatch {
    my $self = shift;
# FIXME

}


sub _execute {
    my ($self, $command) = @_;

    my $curWD = getcwd();

    chdir($self->changeWD) if $self->changeWD;

    print "Running: $command\n" if $self->verbose;

    my $output = qx/$command 2>&1/;
    my $rc = $? >> 8;

    chdir($curWD) unless $curWD eq getcwd();
    return ($rc, $output);
}

1;
