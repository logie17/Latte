package Latte::Expectation;
use Moose;
use Latte::MethodMatcher;
use Latte::ReturnValues;
use Latte::Cardinality;
use Latte::ParametersMatcher;
use Latte::ParametersMatcher::Equals;

has mock => (
	is  		=> 'rw',
	isa 		=> 'Latte::Mock',
);

has cardinality => (
    is          => 'rw',
    isa         => 'Latte::Cardinality',
    default     => sub { Latte::Cardinality->exactly(1) }
);

has invocation_count => (
    is          => 'rw',
    isa         => 'Int',
    default     => sub { 0 }
);

has method_matcher => (
	is			=> 'rw',
    isa         => 'Latte::MethodMatcher',
    default     => sub { Latte::MethodMatcher->new( expected_method_name => $_[0]->method_name ) }
);

has return_values => (
    is          => 'rw',
    isa         => 'Latte::ReturnValues',
    default     => sub { Latte::ReturnValues->new }
);

has method_name => (
    is          => 'rw'
);

has parameters_matcher => (
    is          => 'rw',
    isa         => 'Latte::ParametersMatcher',
    default     => sub { Latte::ParametersMatcher->new }
);

sub invoke {
    my ($self, $block) = @_;
    $self->invocation_count($self->invocation_count + 1);
    return $self->return_values->next;
}


sub returns {
    my ($self, $value) = @_;
    $self->return_values($self->return_values->add(Latte::ReturnValues->new( values => $value )));
    return $self;
}

sub match {
    my ($self, $actual_method_name, @actual_parameters) = @_;
    return ($self->method_matcher->match($actual_method_name) && $self->parameters_matcher->match(@actual_parameters) && $self->in_correct_order) ? 1 : 0;
}

sub invocations_allowed {
    my ($self) = @_;
    $self->cardinality->invocations_allowed($self->invocation_count);
}

sub with {
    my $self = shift;

    my $matching_block         = pop if ref $_[-1] eq 'CODE';
    my @expected_parameters    = map { Latte::ParametersMatcher::Equals->new( value => $_ ) } @_;
    
    $self->parameters_matcher( Latte::ParametersMatcher->new( expected_parameters => \@expected_parameters, matching_block => $matching_block ) );

    return $self;
}


sub in_correct_order {
    1;
}
1;
