package Latte::ParametersMatcher::Equals;
use Moose;

has value => (
    is  => 'rw',
);

sub matches {
    my ( $self, $available_parameters ) = @_;
    return $available_parameters == $self->value;
}

sub latte_inspect {
  return $_[0]->value;
}

1;
