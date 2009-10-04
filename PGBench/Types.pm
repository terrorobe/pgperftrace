package Types;

use Moose;

use Moose::Util::TypeConstraints;

type 'PgBranchName'
        => where { m/^(REL\d_\d_STABLE|HEAD)$/ }
        => message { "String '$_' doesn't look like a Pg branch name" };

type 'BenchName'
        => where { m/sysbench/ }
        => message { "String '$_' doesn't look like a benchmark name" };

type 'ExistingDir'
        => where { -d -w $_ }
        => message { "Directory '$_' either doesn't exist or isn't writeable" };

type 'NonExistingDir'
        => where { ! -e $_ }
        => message { "Directory '$_' already exists" };


1;
