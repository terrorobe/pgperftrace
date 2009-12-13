package BenchFarm::Schema::Result::Job;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "Core");
__PACKAGE__->table("job");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('job_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "batch",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "benchclient",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "benchtype",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "benchconfig",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
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
__PACKAGE__->add_unique_constraint("job_pkey", ["id"]);
__PACKAGE__->belongs_to(
  "benchclient",
  "BenchFarm::Schema::Result::Benchclient",
  { id => "benchclient" },
);
__PACKAGE__->belongs_to("batch", "BenchFarm::Schema::Result::Batch", { id => "batch" });
__PACKAGE__->has_many(
  "results",
  "BenchFarm::Schema::Result::Result",
  { "foreign.job" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-12-11 12:05:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KhqrgGOut/YAGF9EakaHLA


__PACKAGE__->resultset_class('BenchFarm::Schema::ResultSet::Job');
1;
