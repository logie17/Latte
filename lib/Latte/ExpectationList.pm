package Latte::ExpectationList;
use Moose;

sub BUILD
{
    my ($self) = @_;
    
    $self->{expectations} = [];

    return $self;
}

sub add 
{
    my ($self, $expectation) = @_;
    unshift @{$self->{expectations}}, $expectation;
    return $expectation
}

sub match_allowing_invocation
{
    my ( $self, $method_name, @arguments ) = @_;
    return ( grep { $_->invocations_allowed } $self->matching_expectations($method_name, @arguments) );
}    

sub matching_expectations
{
    my ($self, $method_name, @arguments) = @_;

    return ( grep { $_->match($method_name, @arguments) } @{$self->{expectations}} );
}


__PACKAGE__->meta->make_immutable;
no Moose;
1;
