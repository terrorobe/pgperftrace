package PGBench::Benchmark::SysbenchMemory;

use Moose;

use PGBench::Result::SysbenchMemory;

with 'PGBench::Benchmark::Sysbench';

has 'block_size' => (is => 'ro', isa => 'Str', required => 1, default => '8K');
has 'total_size' => (is => 'ro', isa => 'Str', required => 1, default => '100G');
has 'scope' => (is => 'ro', isa => 'Str', required => 1, default => 'global');
has 'hugetlb' => (is => 'ro', isa => 'Str', required => 1, default => 'off');
has 'oper' => (is => 'ro', isa => 'Str', required => 1, default => 'write');
has 'access_mode' => (is => 'ro', isa => 'Str', required => 1, default => 'seq');

sub BUILD {
    my ($self, $params) = @_;

    $self->bench_args($self->bench_args . ' --test=memory'
            . ' --memory-block-size=' . $self->block_size
            . ' --memory-total-size=' . $self->total_size
            . ' --memory-scope=' . $self->scope
            . ' --memory-hugetlb=' . $self->hugetlb
            . ' --memory-oper=' . $self->oper
            . ' --memory-access-mode=' . $self->access_mode
            . ' run'
            );
    $self->result(PGBench::Result::SysbenchMemory->new());
}

sub prepare {
    return;
}

sub cleanup {
    return;
}

sub parseOutput {
    my $self = shift;

    for my $line (@{$self->output}) {

        if ($line =~ m/Operations performed:\s+(\d+)\s+\(([.\d]+)\s+ops/) {
            $self->result->ops($1);
            $self->result->ops_per_sec($2);
        }

        elsif ($line =~ m/([.\d]+)\s+MB\s+transferred\s+\(([.\d]+)\s+MB/) {
            $self->result->transfer($1);
            $self->result->transer_per_sec($2);
        }
    }
}

1;
