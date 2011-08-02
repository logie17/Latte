package Latte::Mock;
use Moose;
use Latte::Expectation;
use Latte::ExpectationList;
use Latte::ArgumentIterator;

has expectations => (
	is  => 'rw',
	isa => 'Latte::ExpectationList',
);

sub BUILD
{
	my ($self) = @_;		
	$self->expectations(Latte::ExpectationList->new);
}

sub ensure_method_not_already_defined
{
	my ($self, $method_name) = @_;

	unless ( $self->meta->has_method($method_name) ) 
	{
		#$self->meta->add_method($method_name, sub { return; } );
		#$self->meta->add_around_method_modifier( $method_name, sub { return; } );
	}
}

sub expects
{
	my ($self, $method_name_or_hash, $backtrace) = @_;

    my $iterator = Latte::ArgumentIterator->new( argument => $method_name_or_hash );

    my $return_expectation;

    $iterator->each (sub{
		my ($method_name, $values) = @_;

		$self->ensure_method_not_already_defined( $method_name );

        my $expectation = Latte::Expectation->new( mock => $self,  method_name => $method_name );

        $expectation->returns($values) if $values;

        $return_expectation = $self->expectations->add($expectation);

	});
	
	return $return_expectation;
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

sub AUTOLOAD
{
    my $self   = shift;
    my ($name) = our $AUTOLOAD =~ /::(\w+)$/;

    # This is obviously not correct
    # It works for now.
    my @objs = $self->expectations->match_allowing_invocation($name, @_);
    if ( my $matching_expectation_allowing_invocation = $self->expectations->match_allowing_invocation($name, @_) )
    {
        $objs[0]->invoke;
    }

}


#__PACKAGE__->meta->make_immutable;
no Moose;
1;
