package mirweb::Controller::search;

use strict;
use warnings;
use base qw(Catalyst::Controller::FormBuilder Catalyst::Controller::BindLex);

sub search : Global Form('/search/search') {
    my ( $self, $c, $query ) = @_;
    my $form = $self->formbuilder;   
    $c->stash->{template} = 'search/search.tt2';
    $form->field(
        name  => 'keyword',
        label => 'Search Keyword: ',
        value => '',
    );
    $form->field(
        name    => 'search_type',
        label   => 'Database Select: ',
        options => [ 'Mature miRNA', 'Stem-loop sequence' ],
        value   => [ 'Mature miRNA' ]
    );
    $form->field(
        name     => 'search_fields',
        label    => 'Search from : ',
        multiple => 1,
        options  => [ 'Database_ID',
                      'Accession',
                      'Species',
                      'Description' ],
         value   => [ 'Database_ID',
                      'Accession',
                      'Species',
                      'Description' ],
    );
    $c->stash->{form} = $form;
    $query = $form->field('keyword')
        if ( $form->submitted && $form->validate );
    return unless $query;    # no query? we're done
    
    $query=~s/^\s+//;
    my $search_type = $form->field('search_type');
    my @search_fields = $form->field('search_fields');
    my @querys = split /\s+/, $query;
    my %colored_replace;
    foreach my $qe (@querys) {
        $colored_replace{$qe} = "<font color=red><b>".$qe."</b></font>";
    }
    my $columns = $c->forward('get_columns', [ $search_type, @search_fields ]);
    #return;
    $c->stash->{query} = $query;
    $c->stash->{querys} = \@querys;
    $c->stash->{replace} = \%colored_replace;
    $c->stash->{search_type} = $search_type;
    $c->forward( 'get_result', $columns );
}

sub advanced_search : Local Form {
    my ( $self, $c, $query ) = @_;
    my $form = $self->formbuilder;
    $c->stash->{template} = 'test.form.tt2';
    $form->field(
        name    => 'search_type',
        label   => 'Database Select :',
        options => [ 'Mature miRNA', 'Stem-loop sequence' ],
        value   => [ 'Mature miRNA' ]
    );
    $form->field(
        name     => 'keyword1',
        label    => 'Keyword :',
        value    => '',
        required => 1,
    );
    $form->field(
        name     => 'search_field1',
        label    => 'In field :',
        type     => 'select',
        options  => [ 'Accession',
                      'Description',
                      'Database_ID',
                      'Species',
                      'Sequence' ],
        value    => [ 'Database_ID' ],
    );
    $form->field(
        name     => 'opt1',
        label    => '',
        type     => 'select',
        options  => [ 'and', 'or'],
        value    => [ 'and' ],
    );
    $form->field(
        name     => 'keyword2',
        label    => 'Keyword :',
        value    => '',
    );
    $form->field(
        name     => 'search_field2',
        label    => 'In field :',
        type     => 'select',
        type     => 'select',
        options  => [ 'Accession',
                      'Description',
                      'Database_ID',
                      'Species',
                      'Sequence' ],
        value    => [ 'Database_ID' ],
    );
    $form->field(
        name     => 'opt2',
        label    => '',
        type     => 'select',
        options  => [ 'and', 'or' ],
        value    => [ 'and' ],
    );
    $form->field(
        name     => 'keyword3',
        label    => 'Keyword :',
        value    => '',
    );
    $form->field(
        name     => 'search_field3',
        label    => 'In field :',
        type     => 'select',
        options  => [ 'Accession',
                      'Description',
                      'Database_ID',
                      'Species',
                      'Sequence' ],
        value    => [ 'Database_ID' ],
    );
    $c->stash->{form} = $form;
    $query = $form->field('keyword')
        if ( $form->submitted && $form->validate );
    return unless $query;    # no query? we're done
        
    my $search_type = $form->field('search_type');
    
    my @search_fields = $form->field('search_fields');

    my $columns = $c->forward('get_columns', [ $search_type, @search_fields ]);
    #return;
    $c->stash->{query} = $query;
    $c->stash->{search_type} = $search_type;
    $c->forward( 'get_result', $columns );
}

sub get_result : Private {
    my ( $self, $c, @columns ) = @_;
    my $search_type = $c->stash->{search_type};
#    my @tokens = split /\s+/, $query;
#    $c->stash->{test} = \@columns;
#    $c->stash->{'template'} = 'test.tt2';
#    return; 
    my $result : Stashed;
    if( 'Mature miRNA' eq $search_type ) {
        $result = $c->forward( 'search_mirs', \@columns );
        #    return; 
        $c->stash->{'template'} = 'search/mir_results.tt2';
    }
    else {
        $result = $c->forward( 'search_hairpins', \@columns );
    #    return;
        $c->stash->{'template'} = 'search/hairpin_results.tt2';
    }
   
    my $page = $c->request->param('page');
    $page = 1 if ( $page !~ /^\d+$/ );
    $result = $result->page($page);
    my $pager : Stashed = $result->pager;
}

sub get_columns : Private {
    my ( $self, $c, $search_type, @search_fields ) = @_;
    #$c->stash->{test} = \@search_fields;
    #$c->stash->{'template'} = 'test.tt2';
    #return; 
    my @columns;
    my $head = ( 'Mature miRNA' eq $search_type ) ? 'mir_' : 'hairpin_';
    while ( @search_fields ) {
        my $temp = shift(@search_fields);
        if ( 'Accession' eq $temp ) {
            push @columns, $head.'accession';
        }
        if ( 'Database_ID' eq $temp ) {
            push @columns, $head.'mirbase_id';
        }
        if ( 'Species' eq $temp ) {
            push @columns, $head.'species';
        }
        if ( 'Description' eq $temp ) {
            push @columns, $head.'description';
        }
    }
    $c->stash->{columns} = \@columns;
    #$c->stash->{test} = \@columns;
    #$c->stash->{'template'} = 'test.tt2';
    #return; 
    \@columns;
}

sub search_mirs : Private {
    my ( $self, $c, @columns ) = @_;
    #$c->stash->{test} = \@columns;
    #$c->stash->{'template'} = 'test.tt2';
    #return; 
    my $query = $c->stash->{query};
    my @tokens = split /\s+/, $query;
    my @mir_fields = cross( \@columns, \@tokens );
    return $c->model('mirDB::Mir')->search( \@mir_fields );
}

sub search_hairpins : Private {
    my ( $self, $c, @columns ) = @_;
#    $c->stash->{test} = \@columns;
#    $c->stash->{'template'} = 'test.tt2';
#    return; 
    my $query = $c->stash->{query};
    my @tokens = split /\s+/, $query;
    my @hairpin_fields = cross( \@columns, \@tokens );
    return $c->model('mirDB::Hairpin')->search( \@hairpin_fields );
}

sub search_uniqmirs : Private {
    my ( $self, $c, @columns ) = @_;
    my $query = $c->stash->{query};
    my @tokens = split /\s+/, $query;
    my @uniqmir_fields = cross( \@columns, \@tokens );
    return $c->model('mirDB::Uniqmir')->search( \@uniqmir_fields );
}

sub cross {
    my $columns = shift || [];
    my $tokens  = shift || [];
    map {s/%/\\%/g} @$tokens;
    my @result;
    foreach my $column (@$columns) {
        push @result, ( map +{ $column => { -like => "%$_%" } }, @$tokens );
    }
    return @result;
}

1;    # End the module with a true value!

