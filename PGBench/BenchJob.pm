package BenchJob;

use Moose;

has 'db_branch' => (is => 'ro', isa => 'Maybe[PgBranchName]');
has 'db_config' => (is => 'ro', isa => 'Maybe[HashRef[Str]]');
has 'benchmark' => (is => 'ro', isa => 'BenchName', required => 1);
has 'benchmark_opts' => (is => 'ro', isa => 'HashRef[Str]', required => 0);#FIXME

1;
