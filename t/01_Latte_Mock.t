use strict;
use warnings;

use Test::More;

use_ok('Latte::Mock') or exit;

my $mock = Latte::Mock->new;

diag "Test a mock heuristic";
$mock->expects('method1')->returns(1);
is $mock->method1, 1;

diag "Test dynamic method creation";
$mock->expects('method2');
ok $mock->can('method2');

diag "Test expecation references";
$mock = Latte::Mock->new;
my $expectation = $mock->expects('method1');
ok $expectation;
is_deeply [$expectation], [$mock->expectations->to_a];

diag "Stubbing should be false by default";
$mock = Latte::Mock->new;
is $mock->everything_stubbed, 0;
$mock->stub_everything;
is $mock->everything_stubbed, 1;

diag "Test should respond to expected method";
$mock = Latte::Mock->new;
$mock->expects('method1');
ok $mock->responds_to('method1');
ok $mock->can('method1');

diag "Test should not respond to unexpected method";
$mock = Latte::Mock->new;
is undef, $mock->responds_to('method1');
is undef, $mock->can('method1');



done_testing;

1;
