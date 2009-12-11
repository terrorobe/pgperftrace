package BenchFarm::Schema::Result::Result;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "Core");
__PACKAGE__->table("result");
__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    default_value => "nextval('result_id_seq'::regclass)",
    is_nullable => 0,
    size => 4,
  },
  "job",
  { data_type => "integer", default_value => undef, is_nullable => 1, size => 4 },
  "systeminfo",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "benchruninfo",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "raw_output",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "parsed_output",
  {
    data_type => "text",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("result_pkey", ["id"]);
__PACKAGE__->add_unique_constraint("result_job_key", ["job"]);
__PACKAGE__->belongs_to("job", "BenchFarm::Schema::Result::Job", { id => "job" });


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2009-12-11 12:05:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RCMWj8Gigwt6g9ptqYGf/w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
