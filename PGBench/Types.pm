package Types;

use Moose;

use Moose::Util::TypeConstraints;

type 'PgBranchName'
        => where { m/^(REL\d_\d_STABLE|HEAD)$/ }
        => message { "String '$_' doesn't look like a Pg branch name" };

type 'BenchName'
        => where { m/^(Sysbench(CPU|Memory))$/ }
        => message { "String '$_' doesn't look like a benchmark name" };

type 'ExistingDir'
        => where { -d $_ }
        => message { "Directory '$_' doesn't exist" };

type 'ExistingWritableDir'
        => where { -d -w $_ }
        => message { "Directory '$_' either doesn't exist or isn't writeable" };

type 'NonExistingDir'
        => where { ! -e $_ }
        => message { "Directory '$_' already exists" };

type 'ExecutableFile'
        => where { -e -r -x $_ }
        => message { "File '$_' doesn't exist, isn't readable or executable" };

1;
