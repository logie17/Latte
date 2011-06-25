package Latte::MethodMatcher;
use Moose;

has 'expected_method_name' => (
    is          => 'rw',
);

sub match 
{
	my ($self, $actual_method_name) = @_;
    return $self->expected_method_name == $actual_method_name;
}
    
sub inspect
{
	my ($self) = @_;
	return $self->expected_method_name;
}

__PACKAGE__->meta->make_immutable;
1;
