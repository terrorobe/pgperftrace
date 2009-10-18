package PGBench::Result::SysbenchFileIO;

use Moose;

with 'PGBench::Result::Sysbench';

has 'read_ops' => (is => 'rw', isa => 'Int');
has 'write_ops' => (is => 'rw', isa => 'Int');
has 'other_ops' => (is => 'rw', isa => 'Int');
has 'total_ops' => (is => 'rw', isa => 'Int');
has 'read_transfer' => (is => 'rw', isa => 'Int');
has 'write_transfer' => (is => 'rw', isa => 'Int');
has 'transfer_per_sec' => (is => 'rw', isa => 'Int');
has 'req_per_sec' => (is => 'rw', isa => 'Num');


1;
