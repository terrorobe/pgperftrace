package BenchFarm::Schema::Result::Batch;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "Core");
__PACKAGE__->table("batch");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('batch_id_seq'::regclass)",
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
  "submitter",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "status",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "created_at",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 0,
    size => 8,
  },
  "completed_at",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => 8,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("batch_pkey", ["id"]);
__PACKAGE__->belongs_to(
  "submitter",
  "BenchFarm::Schema::Result::User",
  { id => "submitter" },
);
__PACKAGE__->has_many(
  "jobs",
  "BenchFarm::Schema::Result::Job",
  { "foreign.batch" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-12-11 12:05:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DFQ1GG+byRukKS4GlGR3Cw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
