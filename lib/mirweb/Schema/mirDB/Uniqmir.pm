package mirweb::Schema::mirDB::Uniqmir;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("uniqmir");
__PACKAGE__->add_columns(
  "uniqmir_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "uniqmir_seq",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "uniqmir_length",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("uniqmir_id");
__PACKAGE__->add_unique_constraint( uniqmir_seq => [qw{uniqmir_seq}], );
__PACKAGE__->has_many(
    mirs => 'mirweb::Schema::mirDB::Mir',
    'uniqmir_id',
    {   foreign_key_column => 'uniqmir_id',
        cascading_delete   => 1,
    }
);
__PACKAGE__->has_many(
    hybrids => 'mirweb::Schema::mirDB::Hybrid',
    'uniqmir_id',
    {   foreign_key_column => 'uniqmir_id',
        cascading_delete   => 1,
    }
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h2k80cFp52QGQrSRdLYr/A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
