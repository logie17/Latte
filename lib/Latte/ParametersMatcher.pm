package Latte::ParametersMatcher;
use Moose;
use Latte::ParametersMatcher::AnyParameters;

has expected_parameters => (
    is => 'rw'
);


sub BUILD {
    my ($self) = @_;
    $self->expected_parameters(Latte::ParametersMatcher::AnyParameters->new);   
}

sub match {
    my ( $self, @actual_parameters) = @_;

    return $self->parameters_match(@actual_parameters);
}

sub parameters_match
{
    my ( $self, @actual_parameters) = @_;
    return $self->expected_parameters->matches(@actual_parameters);
}


1;
