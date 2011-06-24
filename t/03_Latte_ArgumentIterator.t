use strict;
use warnings;

use Test::More tests => 4;

use_ok('Latte::ArgumentIterator') or exit;

diag "Test iterator with a scalar";
my $subject = Latte::ArgumentIterator->new( argument => 'foo');

$subject->each(sub{
	my $argument	= shift;
	is $argument, 'foo';
});

diag "Test iterator with a hash ref";

my $subject = Latte::ArgumentIterator->new( argument => { 'foo' => 'bar' } );

$subject->each(sub{
	my ($method_name, $return_value) = @_;
	is $method_name, 'foo';
	is $return_value, 'bar';
});

