use strict;
use warnings;
use Test::More;

use_ok('Latte::Expectation') or exit;

my $subject = Latte::Expectation->new( method_name => 'foo' );
ok $subject->match('foo', 1, 2, 3);

$subject->with;
ok $subject->match('foo');

$subject->with;
!ok $subject->match('foo', 1, 2, 3);

$subject->with(1, 2, 5);
ok $subject->match('foo', 1, 2, 5);

$subject->with(sub{
    my ( $x, $y, $z ) = @_;
    return $x + $y == $z;
});

done_testing;

1;
