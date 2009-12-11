use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'BenchFarm' }
BEGIN { use_ok 'BenchFarm::Controller::Job' }

ok( request('/job')->is_success, 'Request should succeed' );


