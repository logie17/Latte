package Latte;
use Moose;
use Latte::Mocha;
use Exporter 'import';

our @EXPORT = qw ( mock );

sub mock 
{
    my $name         = shift if ref $_[0] eq 'SCALAR';
    my $expectations = shift || {};

    my $mock = Latte::Mocha->new;
    $mock->expects($expectations)

    return $mock
    
}
__PACKAGE__->meta->make_immutable;

# ABSTRACT: perldoc Latte

=head1 SYNOPSIS

    use Test::More;
    use Latte;

    my $mock  = mock();
    $mock->expects(:foo).with(:bar).at_least_once  # auto-verified at end of test

end


1;
