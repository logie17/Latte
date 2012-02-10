package Latte::ParametersMatcher::AnyParameters;
use Moose;
extends 'Latte::ParametersMatcher::Base';

sub matches {
    my ($self, $available_parameters) = @_;
    while (scalar @{$available_parameters} > 0 ) {
        shift @{$available_parameters};
    }
    return 1;
}

sub latte_inspect {
  return "any_parameters";
}


1;
