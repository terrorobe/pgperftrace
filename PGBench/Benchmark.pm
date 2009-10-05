package Benchmark;

use Moose;

has 'name' => (is => 'ro', isa => 'BenchName');
has 'prepare_commands' => (is => 'ro', isa => 'ArrayRef[Str]', optional => 1);
has 'cleanup_commands' => (is => 'ro', isa => 'ArrayRef[Str]', optional => 1);
has 'bench_commands' => (is => 'ro', isa => 'ArrayRef[Str]');
has 'benchmark_outputfilter' => (is => 'ro', isa => 'CodeRef');
has 'build_dir' => (is => 'ro', isa => 'Str');
has 'db_config_opts' => (is => 'ro', isa => 'HashRef[Str]', optional => 1);

1;
