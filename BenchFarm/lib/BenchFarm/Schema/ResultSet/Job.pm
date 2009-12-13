package BenchFarm::Schema::ResultSet::Job;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 status_is

Search for jobs with a given status

=cut

sub status_is {
    my ($self, $state) = @_;

    return $self->search({
            status => $state,},
            );

}

=head2 client_is

Search for jobs who belong to a given client id

=cut

sub client_is {
    my ($self, $id) = @_;

    return $self->search({
            benchclient => $id,},
            );
}

sub order_by {
    my ($self, $clause) = @_;

    return $self->search(undef,
            {order_by => $clause}
            );
}


sub limit {
    my ($self, $id, $limit) = @_;

    return $self->search(undef,
            {rows => 1},
            );
}


1;
