package Latte::Expectation;
use Moose;
use Latte::MethodMatcher;

has mock => (
	is  		=> 'rw',
	isa 		=> 'Latte::Mock',
	required 	=> 1
);

has method_matcher => (
	is			=> 'ro',
	#isa			=> 'Latte::MethodMatcher',
	builder		=> '_build_method_matcher',
);

sub _build_method_matcher
{
	my ($self, $expected_method_name ) = @_;
	return Latte::MethodMatcher( expected_method_name => $expected_method_name );
}
1;
