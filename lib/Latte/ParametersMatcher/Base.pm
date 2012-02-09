package Latte::ParametersMatcher::Base;
use Moose;
use Latte::ParametersMatcher::Equals;

has to_matcher  => (
    is          => 'rw',
    isa         => 'Latte::ParametersMatcher::Equals',
    default     => sub { Latte::ParametersMatcher::Equals->new(value => shift) }
);

1;
