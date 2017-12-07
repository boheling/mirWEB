package mirweb::Schema::mirDB::Hairpin;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("hairpin");
__PACKAGE__->add_columns(
  "hairpin_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "hairpin_species",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "hairpin_mirbase_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "hairpin_accession",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "hairpin_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "hairpin_seq",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 1023,
  },
  "hairpin_length",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("hairpin_id");
__PACKAGE__->add_unique_constraint( hairpin_mirbase_id => [qw{hairpin_mirbase_id}], );
__PACKAGE__->add_unique_constraint( hairpin_accession  => [qw{hairpin_accession}], );
__PACKAGE__->has_many(
    hairpin_mirs => 'mirweb::Schema::mirDB::HairpinMir',
    'hairpin_id',
    {   foreign_key_column => 'hairpin_id',
        cascading_delete   => 1,
    }
);



# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fmC8Wb6e0nfgLn8S4jqQzA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
