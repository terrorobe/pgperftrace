package Config;

#use Moose;
#
#has 'bench_root_dir' => (is => 'ro', isa => 'ExistingDir', required => 1, lazy_build => 1);
#
#
## FIXME: Needs moar configparsing!
#
#sub _build_bench_root_dir {
#    print "constructed!\n";
#    return '/srv/pgbenchroot';
#}

#Moose fails us.

use vars (%opt);

%opt = (
        bench_root_dir => '/srv/pgbenchroot',
        scratch_dir => '/srv/raid0',
        sysbench_dir => '/opt/sysbench/bin',
       );

1;
