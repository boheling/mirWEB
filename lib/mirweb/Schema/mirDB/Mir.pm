package mirweb::Schema::mirDB::Mir;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("mir");
__PACKAGE__->add_columns(
  "mir_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "uniqmir_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "mir_species",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "mir_mirbase_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "mir_accession",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "mir_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
);
__PACKAGE__->set_primary_key("mir_id");
__PACKAGE__->add_unique_constraint( mir_mirbase_id => [qw{mir_mirbase_id}], );
__PACKAGE__->add_unique_constraint( mir_accession  => [qw{mir_accession}], );
__PACKAGE__->belongs_to(
    uniqmir => 'mirweb::Schema::mirDB::Uniqmir',
    { foreign_key_column => 'uniqmir_id' }
);
__PACKAGE__->has_many(
    hairpin_mirs => 'mirweb::Schema::mirDB::HairpinMir',
    'mir_id',
    {   foreign_key_column => 'mir_id',
        cascading_delete   => 1,
    }
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:DOiPf3QlNCsR7bmWaG+Iwg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
