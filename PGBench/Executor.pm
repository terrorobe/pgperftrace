package Executor;

use Moose;
use Cwd;

has 'verbose' => (is => 'ro', isa => 'Bool', default => 1);
has 'rc' => (is => 'rw', isa => 'Num');
has 'output' => (is => 'rw', isa => 'Str');
has 'confessOnError' => (is => 'rw', isa => 'Bool', default => 1);
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

    if ($rc && $self->confessOnError) {
        print "***\n\nExecution of '$command' returned RC '$rc'\n";
        print "Output follows:\n\n";
        print $output;
        confess "Exiting";
    }

    return ($rc, $output);
}

1;
