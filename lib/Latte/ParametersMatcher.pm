package Latte::ParametersMatcher;
use Moose;
use Latte::ParametersMatcher::AnyParameters;

has expected_parameters => (
    is      => 'rw',
    #isa     => 'Latte::ParametersMatcher::Base',
    default => sub { [Latte::ParametersMatcher::AnyParameters->new] }
);

has matching_block  => (
    is      => 'rw',
    #isa     => 'CodeRef',
);

sub match {
    my ( $self, @actual_parameters) = @_;
    use Data::Dumper;
    return $self->parameters_match( @actual_parameters );
}

sub parameters_match {
    my ( $self, @actual_parameters) = @_;

    my $success = 1;
    for my $expected_param ( @{$self->expected_parameters} ) {
        my $val = shift @actual_parameters;
        $success = $expected_param->matches($val);        
    }
    return $success && ( scalar @actual_parameters == 0 );
        
}


1;
