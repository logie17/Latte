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

__PACKAGE__->meta->make_immutable;
no Moose;
1;
