package PGBench::Result;

use Moose::Role;
use PGBench::SystemInformation;

has 'start_time' => (is => 'rw', isa => 'DateTime');
has 'end_time' => (is => 'rw', isa => 'DateTime');
has 'benchmark_version' => (is => 'rw', isa => 'Num');
has 'successful_run' => (is => 'rw', isa => 'Bool', required => 1, default => 0);
has 'database' => (is => 'ro', isa => 'Database');
has 'systeminfo' => (is => 'ro', isa => 'SystemInformation', required => 1, lazy_build => 1);


sub _build_systeminfo {
    return PGBench::SystemInformation->new();
}


1;
