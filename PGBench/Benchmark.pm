package Benchmark;

use Moose;
use Carp;

has 'name' => (is => 'ro', isa => 'Str');
has 'build_dir' => (is => 'ro', isa => 'Str');
has 'configure_opts' => (is => 'ro', isa => 'Str', default => 'spartaaa');


