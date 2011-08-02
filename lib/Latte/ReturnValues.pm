package Latte::ReturnValues;

use Moose;

has values => (
	is  		=> 'rw',
    default     => 0
);

sub add 
{
    my ($self, $other) = @_;
    return __PACKAGE__->new( values => ( $self->values + $other->values ));
}

sub next
{
    my ($self) = @_;
    return $self->values;
}

__PACKAGE__->meta->make_immutable;
1;
