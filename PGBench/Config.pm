package Config;

# FIXME: This could use a singleton and/or a configparser with a nice config file

use vars (%opt);

%opt = (
        bench_root_dir => '/srv/pgbenchroot',
        scratch_dir => '/srv/raid0/pgbenchscratch',
        sysbench_dir => '/opt/sysbench/bin',
       );

1;
