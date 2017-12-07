package mirweb::Schema::mirDB::Specialties;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("specialties");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => 0, is_nullable => 0, size => 8 },
  "formal_name",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 32 },
  "abbreviation",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 8 },
  "specialty",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 16 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint(
    id => [qw{id}]
    );


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CZnC4aizLSQSCptArv04WA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
