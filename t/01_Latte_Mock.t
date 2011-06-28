use strict;
use warnings;

use Test::More tests => 3;

use_ok('Latte::Mock') or exit;

my $mock = Latte::Mock->new;

diag "Test a mock heuristic";
$mock->expects('method1')->returns(1);
is $mock->method1, 1;

diag "Test dynamic method creation";
$mock->expects('method2');
ok $mock->can('method2');


1;



