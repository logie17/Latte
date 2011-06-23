use strict;
use warnings;

use Test::More tests => 24;

use_ok('Latte::Cardinality') or exit;

my $subject;

diag "Test attributes";
$subject = Latte::Cardinality->new(required => 2, maximum => 3);;
is $subject->required, 2;
is $subject->maximum, 3;

diag "Allow innovacations as long as the maximum has yet to be reached";
$subject = Latte::Cardinality->new(required => 2, maximum => 3);
ok $subject->is_invocations_allowed(0);
ok $subject->is_invocations_allowed(1);
ok $subject->is_invocations_allowed(2);
ok !$subject->is_invocations_allowed(3);

diag "Should be satisfied if invocations so far have reached required threshold";
$subject = Latte::Cardinality->new(required => 2, maximum => 3);
ok !$subject->is_satisfied(0);
ok !$subject->is_satisfied(1);
ok $subject->is_satisfied(2);
ok $subject->is_satisfied(3);

diag "Cardinality should describe";
is Latte::Cardinality->at_least(0)->inspect, 'allowed any number of times';
is Latte::Cardinality->at_most(1)->inspect, 'expected at most once';
is Latte::Cardinality->at_most(2)->inspect, 'expected at most twice'; 
is Latte::Cardinality->at_most(3)->inspect, 'expected at most 3 times'; 
is Latte::Cardinality->at_least(1)->inspect, 'expected at least once'; 
is Latte::Cardinality->at_least(2)->inspect, 'expected at least twice';
is Latte::Cardinality->at_least(3)->inspect, 'expected at least 3 times';
is Latte::Cardinality->exactly(0)->inspect, 'expected never'; 
is Latte::Cardinality->exactly(1)->inspect, 'expected exactly once';
is Latte::Cardinality->exactly(2)->inspect, 'expected exactly twice';
is Latte::Cardinality->times(3)->inspect, 'expected exactly 3 times';
is Latte::Cardinality->times([2,4])->inspect, 'expected between 2 and 4 times';
is Latte::Cardinality->times([1,3])->inspect, 'expected between 1 and 3 times';

