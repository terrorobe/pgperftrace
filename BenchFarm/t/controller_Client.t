use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'BenchFarm' }
BEGIN { use_ok 'BenchFarm::Controller::Client' }

ok( request('/client')->is_success, 'Request should succeed' );


