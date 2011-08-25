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
    $mock->expects('foo')->with('bar')->at_least_once;

=head1 DESCRIPTION

Mocha style mocking for Perl. This is a port of a popular mocking framework
found in Ruby circles known as Mocha. 

=head1 CAVEATS

This is highly unstable at this point. Probably should check back
until version is up to 0.05.


1;
