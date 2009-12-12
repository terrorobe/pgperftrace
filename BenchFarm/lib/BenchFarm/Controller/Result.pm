package BenchFarm::Controller::Result;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

BenchFarm::Controller::Result - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched BenchFarm::Controller::Result in Result.');
}



sub list : Local : Args(0) {
    my ( $self, $c ) = @_;

    $c->stash->{results} = [$c->model('DB::Result')->all];

    $c->stash->{template} = 'result/list.tt';

}

=head1 AUTHOR

robe,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
