package DatabaseInstance;

use Moose;

extends 'DatabaseBuild';

has 'port' => (is => 'ro', isa => 'Num', required => 1);
has 'datapath' => (is => 'ro', isa => 'NonExistingDir', required => 1);
has 'config_options' => (is => 'ro', isa => 'ArrayRef[Str]');
has 'initdb_options' => (is => 'ro', isa => 'Str'=> 1);


1;
