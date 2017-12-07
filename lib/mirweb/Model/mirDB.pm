package mirweb::Model::mirDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'mirweb::Schema::mirDB',
    connect_info => [
        'dbi:mysql:database=mirDB_test;host=202.119.43.6;port=3306',
        'alignDB',
        'alignDB',
        
    ],
);

=head1 NAME

mirweb::Model::mirDB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<mirweb>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<mirweb::Schema::mirDB>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
