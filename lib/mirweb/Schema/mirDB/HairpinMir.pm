package mirweb::Schema::mirDB::HairpinMir;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("hairpin_mir");
__PACKAGE__->add_columns(
  "hairpin_mir_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "hairpin_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "mir_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "mir_start",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "mir_end",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "evidence",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "similarity",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "experiment",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "reference",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
);
__PACKAGE__->set_primary_key("hairpin_mir_id");
__PACKAGE__->add_unique_constraint( hairpin_and_mir=>[qw{hairpin_id mir_id}]);
__PACKAGE__->belongs_to(
    hairpin => 'mirweb::Schema::mirDB::Hairpin',
    { foreign_key_column => 'hairpin_id' }
);
__PACKAGE__->belongs_to(
    mir => 'mirweb::Schema::mirDB::Mir',
    { foreign_key_column => 'mir_id' }
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:thxQRYQ5K7Js+b6e1+1/Sg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
