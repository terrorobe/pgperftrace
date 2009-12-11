use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'BenchFarm' }
BEGIN { use_ok 'BenchFarm::Controller::Batch' }

ok( request('/batch')->is_success, 'Request should succeed' );


