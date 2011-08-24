package Latte::Mock;
use Moose;
use Latte::Expectation;
use Latte::ExpectationList;
use Latte::ArgumentIterator;

with 'MooseX::Role::MissingMethodUtils';

has expectations => (
	is  => 'rw',
	isa => 'Latte::ExpectationList',
);

has everything_stubbed => (
    traits  => ['Bool'],
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
    handles => {
        stub_everything => 'toggle'
    }
);

sub BUILD
{
	my ($self) = @_;		
	$self->expectations(Latte::ExpectationList->new);
    $self->{instance_methods}   = {};
    $self->{everything_stubbed} = 0;
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

sub method_missing
{
    my ( $self, $method_name, @params ) = @_;


    if ( !$self->{instance_methods}->{$method_name}->{invoke_ready} )
    {
        if ( my $matching_expectation_allowing_invocation = $self->expectations->match_allowing_invocation($method_name, @_) )
        {
            $self->{instance_methods}->{$method_name}->{method} = sub {
                $matching_expectation_allowing_invocation->invoke;
            };

            $self->{instance_methods}->{$method_name}->{invoke_ready} = 1;
            
        }
    }

    if ( $self->{instance_methods}->{$method_name}->{invoke_ready} ) 
    {
        return $self->{instance_methods}->{$method_name}->{method}();
    }

}

sub responds_to
{
    my ($self, $method_name) = @_;

    return 1 if $self->{instance_methods}->{$method_name}->{method};

    return;
}


__PACKAGE__->meta->make_immutable;
no Moose;
1;
