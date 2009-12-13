package BenchFarm::Schema::ResultSet::Benchclient;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';


=head2 name_is

A predefined search for a client with given name

=cut

sub name_is {
    my ($self, $name) = @_;

    return $self->search({
            name => $name,
            });
}

1;
