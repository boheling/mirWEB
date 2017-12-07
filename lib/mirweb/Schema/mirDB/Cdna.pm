package mirweb::Schema::mirDB::Cdna;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("cdna");
__PACKAGE__->add_columns(
  "cdna_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "cdna_ensembl_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "cdna_type",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "cdna_ensembl_gene_id",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 64 },
  "cdna_description",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 255,
  },
  "cdna_seq",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "cdna_length",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("cdna_id");
__PACKAGE__->add_unique_constraint(
    cdna_ensembl_id => [qw{cdna_ensembl_id}] );
__PACKAGE__->add_unique_constraint(
    cdna_ensembl_gene_id => [qw{cdna_ensembl_gene_id}] );
__PACKAGE__->has_many(
    hybrids => 'mirweb::Schema::mirDB::Hybrid',
    'cdna_id',
    {   foreign_key_column => 'cdna_id',
        cascading_delete   => 1,
    }
);


# Created by DBIx::Class::Schema::Loader v0.04005 @ 2008-05-04 21:08:32
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RjDXeSCl9NDdliEhrs7r6Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
