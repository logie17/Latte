package Latte::Mock;
use Moose;
use Latte::ExpectationList;

has expectation_list => (
	is  => 'rw',
	isa => 'Latte::ExpectationList',
);

sub BUILD
{
	my ($self) = @_;		
	$self->expectation_list(Latte::ExpectationList->new);
}

sub expects
{
	my ($self, $method) = @_;
	return $self;
}

sub stubs
{

}

sub responds_like
{

}

sub responds_to
{
}

sub returns
{
	1;
}

# Temporary
sub method1
{
	returns shift;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
