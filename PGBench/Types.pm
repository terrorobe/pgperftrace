package Types;

use Moose;
use Carp;

use Moose::Util::TypeConstraints;

type 'PgBranchName'
        => where { m/^(REL\d_\d_STABLE|HEAD)$/ }
        => message { "String '$_' doesn't look like a Pg branch name" };

type 'BenchName'
        => where { m/sysbench/ }
        => message { "String '$_' doesn't look like a benchmark name" };
