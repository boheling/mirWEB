package mirweb::Schema::mirDB::Species;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("species");
__PACKAGE__->add_columns(
  "species_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "ncbi_taxon_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 16 },
  "formal_name",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 32 },
  "abbreviation",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 8 },
  "chinese_name",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 32 },
  "mir_count",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);

__PACKAGE__->set_primary_key('species_id');
__PACKAGE__->add_unique_constraint(
    abbreviation => [qw{abbreviation}] );



# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ii/PTSgkeABZOeYOvIksaw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
