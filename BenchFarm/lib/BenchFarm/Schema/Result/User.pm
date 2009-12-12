package BenchFarm::Schema::Result::User;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "Core");
__PACKAGE__->table('"user"');
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('user_id_seq'::regclass)",
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
  "password",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "email",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "role",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("user_pkey", ["id"]);
__PACKAGE__->has_many(
  "batches",
  "BenchFarm::Schema::Result::Batch",
  { "foreign.submitter" => "self.id" },
);
__PACKAGE__->has_many(
  "benchclients",
  "BenchFarm::Schema::Result::Benchclient",
  { "foreign.maintainer" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-12-11 12:05:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ncGSg+cGWaYff/vwthUJ/g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
