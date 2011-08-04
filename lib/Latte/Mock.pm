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
    $self->{instance_methods} = {};
}

sub ensure_method_not_already_defined
{
	my ($self, $method_name) = @_;

	unless ( $self->meta->has_method($method_name) ) 
	{
        $self->{instance_methods}->{$method_name} = { 
            method          => sub{},
            invoke_ready    => 0
        };
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

    my $meth_ref = $self->can($name);

    if ( $meth_ref && !$self->{instance_methods}->{$name}->{invoke_ready} )
    {
        if ( my $matching_expectation_allowing_invocation = $self->expectations->match_allowing_invocation($name, @_) )
        {
            $self->{instance_methods}->{$name}->{method} = sub {
                $matching_expectation_allowing_invocation->invoke;
            };
            $self->{instance_methods}->{$name}->{invoke_ready} = 1;
            
            $meth_ref = $self->can($name);
        }
    }

    goto &{$meth_ref} if $meth_ref;

    return;
}

sub can
{
    my ($self, $method) = @_;

    my $meth_ref = $self->SUPER::can($method);

    return $meth_ref if $meth_ref && !$self->{instance_methods}->{$method};
   
    if ( my $meth_ref = $self->{instance_methods}->{$method}->{method} )
    {
        no strict 'refs';
        return *{ $method } = $meth_ref;
    }

    return;
}


#__PACKAGE__->meta->make_immutable;
no Moose;
1;
