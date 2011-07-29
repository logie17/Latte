package Latte::Cardinality;
use Moose;

use constant INFINITY => ( 9**9**9 );

has required => (
	is  		=> 'ro',
    required 	=> 1,
);

has maximum => (
	is  		=> 'ro',
    required 	=> 1,
);

# ~~Class Methods

sub at_least 
{
	my $count = $_[1];
    return __PACKAGE__->new( required => $count, maximum => INFINITY );
}

sub at_most 
{
	my $count = $_[1];
  	return __PACKAGE__->new( required => 0, maximum => $count );
}

sub exactly
{
	my $count  = $_[1];
  	return __PACKAGE__->new( required => $count, maximum => $count );
}

# ~~Instance Methods

sub invocations_allowed
{
    my ($self, $invocation_count) = @_;
    return $invocation_count < $self->maximum
}

sub inspect 
{
	my ($self) = @_;

  	if ($self->is_allowed_any_number_of_times) 
	{
    	return "allowed any number of times";
  	}
	else
	{
    	if ($self->required == 0 && $self->maximum == 0) 
		{
    	  	return "expected never";
		}
    	elsif ($self->required == $self->maximum )
		{
    	  	return "expected exactly " . $self->times($self->required);
		}
    	elsif ( $self->maximum == INFINITY )
		{
    	  	return "expected at least " . $self->times($self->required);
		}
    	elsif ( $self->required == 0 )
		{
    		return "expected at most " . $self->times($self->maximum);
		}
    	else
		{
    	  	return "expected between " . $self->required . " and " . $self->times($self->maximum);
		}
	}
}

sub is_allowed_any_number_of_times 
{
	my ($self) = @_;
  	return ($self->required == 0 && $self->maximum == INFINITY);
}

sub is_invocations_allowed 
{
	my ( $self, $invocation_count ) = @_;
	return $invocation_count < $self->maximum;
}

sub is_satisfied
{
	my ( $self, $invocations_so_far ) = @_;
  	return $invocations_so_far >= $self->required;
}

# ~~Hybrid Class/Instance

sub times
{
	my ( $proto, $param) = @_;
	
	# This is refactor ready
	if ( ref $proto )
	{
		my $number = $param;
		return 	$number == 0 ? 'no times' : 
				$number == 1 ? 'once' 	  :
				$number == 2 ? 'twice'	  :
				$number . " times";
	}
	else
	{
		if ( ref $param eq 'ARRAY' )
		{
			return __PACKAGE__->new( required => $param->[0], maximum => $param->[1] );	
		}	
		else
		{
			return __PACKAGE__->new( required => $param, maximum => $param );	
		}
	}
}

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Latte::Cardinality

=head1 SYNOPSIS

my $cardinal_obj = Latte::Cardinality->new( required => 2, maximum => 3 );

=head1 DESCRIPTION

This class is used to keep track of a set of calls.

=head1 CLASS METHODS

=head2 at_least 

=head2 at_most 

=head2 exactly

=head2 times

=head1 INSTANCE METHODS

=head2 inspect

=head2 is_allowed_any_number_of_times 

=head2 is_invocations_allowed 

=head2 is_satisfied

=head2 times
