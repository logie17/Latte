use strict;
use warnings;

use Test::More tests => 2;

use_ok('Latte::Mock') or exit;

my $mock = Latte::Mock->new;

# ~Test should set single expectation
$mock->expects('method1')->returns(1);
is $mock->method1, 1;

1;



