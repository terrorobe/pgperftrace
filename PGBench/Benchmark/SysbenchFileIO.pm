package PGBench::Benchmark::SysbenchFileIO;

use Moose;

with 'PGBench::Benchmark::Sysbench';

# We almost certainly want to use 
# --file-extra-flags=direct --file-block-size=8192

#robe@testbox:/srv/raid0/sysbench$ /opt/sysbench/bin/sysbench --num-threads=8 --max-requests=10000 --test=fileio --file-extra-flags=direct --file-block-size=8192 --file-test-mode=rndrd run &
#
#
#Operations performed:  10000 Read, 0 Write, 0 Other = 10000 Total
#Read 78.125Mb  Written 0b  Total transferred 78.125Mb  (3.5503Mb/sec)
#      454.44 Requests/sec executed
#

1;
