package PGBench::Result::Sysbench;

use Moose::Role;

with 'PGBench::Result';

has 'total_time' => (is => 'rw', isa => 'Num');
has 'total_num_events' => (is => 'rw', isa => 'Int');
has 'per_req_min_dur' => (is => 'rw', isa => 'Num');
has 'per_req_avg_dur' => (is => 'rw', isa => 'Num');
has 'per_req_max_dur' => (is => 'rw', isa => 'Num');
has 'per_req_95p_dur' => (is => 'rw', isa => 'Num');
has 'per_thread_avg_events' => (is => 'rw', isa => 'Num');
has 'per_thread_avg_events_stddev' => (is => 'rw', isa => 'Num');
has 'per_thread_avg_time' => (is => 'rw', isa => 'Num');
has 'per_thread_avg_time_stddev' => (is => 'rw', isa => 'Num');

1;
