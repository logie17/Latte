package Latte::Expectation;
use Moose;
use Latte::MethodMatcher;
use Latte::ReturnValues;
use Latte::Cardinality;
use Latte::ParametersMatcher;

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
	is			=> 'rw',
);

has return_values => (
    is          => 'rw'
);

has method_name => (
    is          => 'rw'
);

has parameters_matcher => (
    is          => 'rw',
    isa         => 'Latte::ParametersMatcher'
);

sub BUILD
{
    my ($self) = @_;
    $self->return_values(Latte::ReturnValues->new);
    $self->cardinality(Latte::Cardinality->exactly(1)); 
    $self->invocation_count(0);
    $self->method_matcher(Latte::MethodMatcher->new( expected_method_name => $self->method_name ));
    $self->parameters_matcher(Latte::ParametersMatcher->new);
}

sub invoke
{
    my ($self, $block) = @_;
    $self->invocation_count($self->invocation_count + 1);
    return $self->return_values->next
}


sub returns
{
    my ($self, $value) = @_;
    $self->return_values($self->return_values->add(Latte::ReturnValues->new( values => $value )));
    return $self;
}

sub match 
{
    my ($self, $actual_method_name, @actual_parameters) = @_;
    $self->method_matcher->match($actual_method_name) && $self->parameters_matcher->match(@actual_parameters) && $self->in_correct_order;
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
