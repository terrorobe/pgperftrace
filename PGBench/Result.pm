package PGBench::Result;

use Moose::Role;

has 'start_time' => (is => 'ro', isa => 'DateTime', required => 1);
has 'end_time' => (is => 'ro', isa => 'DateTime', required => 1);
has 'benchmark_version' => (is => 'ro', isa => 'Num', required => 1);
has 'successful_run' => (is => 'ro', isa => 'Bool', required => 1);
has 'database' => (is => 'ro', isa => 'Database');
has 'systeminfo' => (is => 'ro', isa => 'SystemInformation', required => 1);



1;
