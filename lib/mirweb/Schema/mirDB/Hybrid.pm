package mirweb::Schema::mirDB::Hybrid;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("hybrid");
__PACKAGE__->add_columns(
  "hybrid_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "uniqmir_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "cdna_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "hybrid_mfe",
  { data_type => "DOUBLE", default_value => undef, is_nullable => 1, size => 64 },
  "hybrid_p_value",
  { data_type => "DOUBLE", default_value => undef, is_nullable => 1, size => 64 },
  "hybrid_position",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "hybrid_graph",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
);
__PACKAGE__->set_primary_key("hybrid_id");
__PACKAGE__->belongs_to(
    uniqmir => 'mirweb::Schema::mirDB::Uniqmir',
    { foreign_key_column => 'uniqmir_id' }
);
__PACKAGE__->belongs_to(
    cdna => 'mirweb::Schema::mirDB::Cdna',
    { foreign_key_column => 'cdna_id' }
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+cgH2SBscDyvELD9ytzCoA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
