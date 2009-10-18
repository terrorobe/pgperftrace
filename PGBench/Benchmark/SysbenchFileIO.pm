package PGBench::Benchmark::SysbenchFileIO;

use Moose;

use PGBench::Result::SysbenchFileIO;

with 'PGBench::Benchmark::Sysbench';

has 'file_num' => (is => 'ro', isa => 'Int', required => 1, default => 128);
has 'block_size' => (is => 'ro', isa => 'Int', required => 1, default => 8192);
has 'total_size' => (is => 'ro', isa => 'Str', required => 1, default => '2G');
has 'test_mode' => (is => 'ro', isa => 'Str', required => 1, default => 'rndrd');
has 'io_mode' => (is => 'ro', isa => 'Str', required => 1, default => 'sync');
has 'extra_flags' => (is => 'ro', isa => 'Str', required => 1, default => 'direct');
has 'fsync_freq' => (is => 'ro', isa => 'Int', required => 1, default => 100);
has 'fsync_all' => (is => 'ro', isa => 'Str', required => 1, default => 'off');
has 'fsync_end' => (is => 'ro', isa => 'Str', required => 1, default => 'on');
has 'fsync_mode' => (is => 'ro', isa => 'Str', required => 1, default => 'fsync');
has 'merged_requests' => (is => 'ro', isa => 'Int', required => 1, default => '0');
has 'rw_ratio' => (is => 'ro', isa => 'Num', required => 1, default => '1.5');
has 'workdir' => (is => 'ro', isa => 'ExistingWritableDir', required => 1, lazy_build => 1);



sub BUILD {
    my ($self, $params) = @_;

    $self->bench_args($self->bench_args . ' --test=fileio'
            . ' --file-num=' . $self->file_num
            . ' --file-block-size=' . $self->block_size
            . ' --file-total-size=' . $self->total_size
            . ' --file-test-mode=' . $self->test_mode
            . ' --file-io-mode=' . $self->io_mode
            . ' --file-extra-flags=' . $self->extra_flags
            . ' --file-fsync-freq=' . $self->fsync_freq
            . ' --file-fsync-all=' . $self->fsync_all
            . ' --file-fsync-end=' . $self->fsync_end
            . ' --file-fsync-mode=' . $self->fsync_mode
            . ' --file-merged-requests=' . $self->merged_requests
            . ' --file-rw-ratio=' . $self->rw_ratio
            );

    $self->result(PGBench::Result::SysbenchFileIO->new());
}

sub _build_workdir {
    my $self = shift;

    my $scratchdir = $Config::opt{'scratch_dir'};
    my $workdir = $scratchdir . '/sysbench';

    unless (-d -w $scratchdir) {
        confess "Directory '$scratchdir' doesn't exist or isn't writable";
    }

    unless (-d $workdir ) {
        mkdir($workdir) or confess "Failed to create '$workdir'";
    }

    return $workdir;
}

sub prepare {
    my $self = shift;
    my $executor = Executor->new(changeWD => $self->workdir);
    my $command = $self->sysbench . $self->bench_args . ' prepare';

    $executor->runCommand($command);
}

sub cleanup {
    my $self = shift;
    my $executor = Executor->new(changeWD => $self->workdir);
    my $command = $self->sysbench . $self->bench_args . ' cleanup';

    $executor->runCommand($command);
}


sub parseOutput {

    my $self = shift;

    my $RE_ops = qr/
        Operations\s+performed:
        \s+(\d+)\s+Read,
        \s+(\d+)\s+Write,
        \s+(\d+)\s+Other
        \s+=\s+(\d+)\s+Total
        /x;

    my $units = '([GMK])?b';

    my $RE_throughput = qr/
        Read\s+([.\d]+)$units
        \s+Written\s+([.\d]+)$units
        \s+Total\s+transferred\s+([.\d]+)$units
        \s+\(([.\d]+)$units\/sec
        /x;

    for my $line (@{$self->output}) {

        if ($line =~ m/$RE_ops/) {
            $self->result->read_ops($1);
            $self->result->write_ops($1);
            $self->result->other_ops($1);
            $self->result->total_ops($1);
        }

        elsif ($line =~ m/$RE_throughput/) {
            print "I matched!\n\n\n";
            $self->result->read_transfer(_translate_unit($1, $2));
            $self->result->write_transfer(_translate_unit($3, $4));
            $self->result->total_transfer(_translate_unit($5, $6));
            $self->result->transfer_per_sec(_translate_unit($7, $8));
        }

        elsif ($line =~ m/([.\d]+)\s+Requests\/sec\s+executed/) {
            $self->result->req_per_sec($1);

        }
    }
}

sub _translate_unit {
    my ($amount, $unit) = @_;

    my $multiplicator = 1;

    $unit ||= '';

    if ($unit eq 'G') {
        $multiplicator = 1024**3
    }
    elsif ($unit eq 'M') {
        $multiplicator = 1024**2;
    }
    elsif ($unit eq 'K') {
        $multiplicator = 1024;
    }

    return $amount * $multiplicator;
}

#Operations performed:  10000 Read, 0 Write, 0 Other = 10000 Total
#Read 78.125Mb  Written 0b  Total transferred 78.125Mb  (3.5503Mb/sec)
#      454.44 Requests/sec executed
#

1;
