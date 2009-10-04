package BenchJob;

use Moose;
use Carp;


# FIXME - squeeze dependency - switch to more history type of method calling validation?
# use MooseX::Params::Validate;

my @jobs;

# FIXME
# This is more horrible than I want it to be. This sure is possibly in a more OO-ish way.

sub add_job {

#    my ($self, %params) = validated_hash(
#            \@_,
#            release => { isa => 'PgBranchName' },
#            config_opts => { isa => 'Str', default => ''},
#            benchmarks => { isa => 'ArrayRef[BenchName]'},
#            ); 
#
    my ($self, %params) = @_;;

# Delete empty config opts FIXME
    delete($params{'config_opts'}) if (exists $params{'config_opts'} && ! $params{'config_opts'});
# Look ma, no validation!

    push @jobs, \%params;

    return;
}

sub get_jobs {

    return @jobs;

}

1;
