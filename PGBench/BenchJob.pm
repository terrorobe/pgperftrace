package BenchJob;

use Moose;

has 'release' => (is => 'ro', isa => 'PgBranchName');
has 'config_opts' => (is => 'ro', isa => 'Maybe[HashRef[str]]');
has 'benchmarks' => (is => 'ro', isa => 'ArrayRef[BenchName]');


1;
