package PGBench::Result::Sysbench;

use Moose::Role;

with 'PGBench::Result';

has 'total_time' => (is => 'ro', isa => 'Num', required => 1);
has 'total_num_events' => (is => 'ro', isa => 'Int', required => 1);
has 'per_req_min_dur' => (is => 'ro', isa => 'Num', required => 1);
has 'per_req_avg_dur' => (is => 'ro', isa => 'Num', required => 1);
has 'per_req_max_dur' => (is => 'ro', isa => 'Num', required => 1);
has 'per_req_95p_dur' => (is => 'ro', isa => 'Num', required => 1);
has 'per_thread_avg_events' => (is => 'ro', isa => 'Num', required => 1);
has 'per_thread_avg_events_stddev' => (is => 'ro', isa => 'Num', required => 1);
has 'per_thread_avg_time' => (is => 'ro', isa => 'Num', required => 1);
has 'per_thread_avg_time_stddev' => (is => 'ro', isa => 'Num', required => 1);

1;
