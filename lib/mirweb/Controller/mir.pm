package mirweb::Controller::mir;

use strict;
use warnings;
use base qw(Catalyst::Controller::FormBuilder Catalyst::Controller::BindLex);

sub list : Local {
    my ( $self, $c ) = @_;
    $c->stash->{search_type} = 'Mature miRNA';
    my @columns = qw/mir_mirbase_id/; 
    $c->forward( '/search/get_result', \@columns );
#   my $mirs : Stashed = $c->model('mirDB::Mir');
#   $c->stash->{template} = 'mir/list.tt2';
}

1;    # End the module with a true value!

