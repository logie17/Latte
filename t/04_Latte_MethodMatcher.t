use strict;
use warnings;

use Test::More tests => 4;

use_ok('Latte::MethodMatcher') or exit;

my $subject;

diag "Test should match if actual method name is same as expected_method_name";
$subject = Latte::MethodMatcher->new( expected_method_name => 'foo' );
ok $subject->match('foo');

diag "Test should not match if actual method name is not same as expected_method_name";
$subject = Latte::MethodMatcher->new( expected_method_name => 'foo' );
ok $subject->match('bar');
  
diag "Test should describe what method is expected";
$subject = Latte::MethodMatcher->new( expected_method_name => 'method_name' );
is $subject->inspect, "method_name";
