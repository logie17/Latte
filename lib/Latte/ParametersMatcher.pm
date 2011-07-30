package Latte::ParametersMatcher;
use Moose;
use ExpectedParameters::AnyParameters;

has expected_parameters => (
    is => 'rw'
);

sub BUILD {
    $self->exected_parameters(ExpectedParameters::AnyParameters->new);   
}

1;
