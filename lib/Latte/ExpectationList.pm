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
    return $self->matching_expectations($method_name, *arguments).grep { |e| e.invocations_allowed? }
}    

sub matching_expectations
{
    my ($self, $method_name, @arguments) = @_;
    @expectations.select { |e| e.match?(method_name, *arguments) }
}


__PACKAGE__->meta->make_immutable;
no Moose;
1;
