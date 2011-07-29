package Latte::Expectation;
use Moose;
use Latte::MethodMatcher;
use Latte::ReturnValues;
use Latte::Cardinality

has mock => (
	is  		=> 'rw',
	isa 		=> 'Latte::Mock',
	required 	=> 1
);

has cardinality => (
    is          => 'rw',
    isa         => 'Latte::Cardinality'
);

has invocation_count => (
    is          => 'rw'
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
    $self->cardinality(Latte::Cardinality->exactly(1)); 
    $self->invocation_count(0);
}

sub returns
{
    my ($self, $value) = @_;
    $self->return_values->add(Latte::ReturnValues->new( values => $value ));
    return $self;
}

sub match 
{
    my ($self, $actual_method_name, @actual_parameters) = @_;
    $self->method_matcher->match($actual_method_name) && $self->parameters_matcher->match(@actual_parameters) && $self->in_correct_order;
}

sub _build_method_matcher
{
	my ($self, $expected_method_name ) = @_;
	return Latte::MethodMatcher( expected_method_name => $expected_method_name );
}

sub invocations_allowed
{
    my ($self) = @_;
    $self->cardinality->invocations_allowed($self->invocation_count)
}


sub in_correct_order 
{
    1;
}
1;
