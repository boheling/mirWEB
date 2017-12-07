package mirweb::Controller::detail;
use strict;
use warnings;
use base qw(Catalyst::Controller::FormBuilder Catalyst::Controller::BindLex);

sub mirs : Local {
    my ( $self, $c, $mir_mirbase_id ) = @_;
    my $mir_result : Stashed;
    
    my @mir_columns = qw/mir_mirbase_id/;
    $c->stash->{query} = $mir_mirbase_id;
    $mir_result = $c->forward( '/search/search_mirs', \@mir_columns );
    my $mir_obj = $mir_result->next;
    $c->stash->{mir} = $mir_obj;
    
    my @uniq_columns = qw/uniqmir_id/;
    $c->stash->{query} = $mir_obj->uniqmir_id;
    my $uniq_result : Stashed;
    $uniq_result = $c->forward( '/search/search_uniqmirs', \@uniq_columns );
    my $uniqmir_obj = $uniq_result->next;
    $c->stash->{uniqmir} = $uniqmir_obj;
    $c->stash->{'template'} = 'detail/mir_detail.tt2';    
}

sub hairpins : Local {
    my ( $self, $c, $hairpin_mirbase_id ) = @_;
    my $result : Stashed;
    
    my @hairpin_columns = qw/hairpin_mirbase_id/;
    $c->stash->{query} = $hairpin_mirbase_id;   
    $result = $c->forward( '/search/search_hairpins', \@hairpin_columns );
    my $hairpin_obj = $result->next;
    $c->stash->{hairpin} = $hairpin_obj;
    $c->stash->{'template'} = 'detail/hairpin_detail.tt2';    
}

1;
