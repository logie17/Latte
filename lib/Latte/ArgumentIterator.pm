package Latte::ArgumentIterator;
use Moose;

has argument => (
	is  		=> 'ro',
    required 	=> 1,
);

sub each 
{
	my ( $self, $sub_ref) = @_;	

	my $argument = $self->argument;

	if ( ref $argument eq 'HASH' ) 
	{
		while (	my ( $method_name, $return_value ) = each(%{$argument})) { &{$sub_ref}($method_name, $return_value) }
	}
	else
	{
		&{$sub_ref}($argument);
	}
	
}


__PACKAGE__->meta->make_immutable;
no Moose;
1;
