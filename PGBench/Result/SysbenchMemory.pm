package PGBench::Result::SysbenchMemory;

use Moose;

with 'PGBench::Result::Sysbench';

has 'ops' => (is => 'rw', isa => 'Int');
has 'ops_per_sec' => (is => 'rw', isa => 'Num');
has 'transfer' => (is => 'rw', isa => 'Num');
has 'transer_per_sec' => (is => 'rw', isa => 'Num');

1;
