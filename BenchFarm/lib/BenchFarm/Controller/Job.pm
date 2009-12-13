package BenchFarm::Controller::Job;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

BenchFarm::Controller::Job - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->forward('list');
}


=head2 list

List all jobs

=cut

sub list : Local : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{jobs} = [$c->model('DB::Job')->all];

    $c->stash->{template} = 'job/list.tt';

}


=head2 find_client

Finds client as part of the chain

=cut

sub client :Chained('/') :PathPart('job/client') :CaptureArgs(1) {
    my ($self, $c, $clientname) = @_;

    my $client = $c->model('DB::BenchClient')
        ->name_is($clientname)
        ->single;

    $c->stash(client => $client);

    die "Client $clientname not found" unless $c->stash->{client};
}

=head2 get_next_job

Get the next job of a given client, if there are any

=cut

sub get_next_job :Chained('client') :PathPart('get_next_job') :Args(0) {
    my ( $self, $c, $clientname ) = @_;

    my $clientid = $c->stash->{client}->id;
    my $job = $c->model('DB::Job')
        ->client_is($clientid)
        ->status_is('open')
        ->order_by('created_at ASC')
        ->limit(1)
        ->single;

# FIXME: ORDER BY...

    $c->stash->{JSON} = {
        id => $job->id,
        benchmark => $job->benchtype,
        benchconfig => $job->benchconfig,
    };

    $c->forward('BenchFarm::View::JSON');

}


=head2 update_job

Update the status of a job

=cut

sub update_job {
    my ( $self, $c ) = @_;

}

=head1 AUTHOR

robe,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
