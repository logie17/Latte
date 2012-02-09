package Latte::ParametersMatcher::AnyParameters;
use Moose;
extends 'Latte::ParametersMatcher::Base';

sub matches {
    return 1;
}

sub latte_inspect {
  return "any_parameters";
}


1;
