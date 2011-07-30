package Latte::ParametersMatcher::AnyParameters;
use Moose;

sub matches()
{
    return 1;
}

sub latte_inspect()
{
  return "any_parameters";
}


1;
