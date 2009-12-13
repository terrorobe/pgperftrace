package BenchFarm::Schema::Result::Benchclient;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "Core");
__PACKAGE__->table("benchclient");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('benchclient_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "name",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "authkey",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "maintainer",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "servermodel",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "processor",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "ram",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "storage",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "os",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("benchclient_pkey", ["id"]);
__PACKAGE__->add_unique_constraint("benchclient_name_key", ["name"]);
__PACKAGE__->belongs_to(
  "maintainer",
  "BenchFarm::Schema::Result::User",
  { id => "maintainer" },
);
__PACKAGE__->has_many(
  "jobs",
  "BenchFarm::Schema::Result::Job",
  { "foreign.benchclient" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-12-11 12:05:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0RQVTnvPYVD75bFNQPxg3Q



__PACKAGE__->resultset_class('BenchFarm::Schema::ResultSet::Benchclient');
1;
