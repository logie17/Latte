package Latte::Expectation;
use Moose;
use Latte::MethodMatcher;
use Latte::ReturnValues;

has mock => (
	is  		=> 'rw',
	isa 		=> 'Latte::Mock',
	required 	=> 1
);

has method_matcher => (
	is			=> 'ro',
	builder		=> '_build_method_matcher',
);

has return_values => (
    is          => 'rw'
);

sub BUILD
{
    my ($self) = @_;
    $self->return_values(Latte::ReturnValues->new);
}

sub returns
{
    my ($self, $value) = @_;
    $self->return_values->add(Latte::ReturnValues->new( values => $value ));
    return $self;
}

sub _build_method_matcher
{
	my ($self, $expected_method_name ) = @_;
	return Latte::MethodMatcher( expected_method_name => $expected_method_name );
}
1;
