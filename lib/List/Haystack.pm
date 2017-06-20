package List::Haystack;
use 5.008001;
use strict;
use warnings;
use Carp qw/croak/;

our $VERSION = "0.01";

sub new {
    my ($class, $list, $options) = @_;

    if (not defined $list) {
        croak 'Argument `$ad` is missing. It is a mandatory argument.';
    }

    if (ref $list ne 'ARRAY') {
         croak 'Type of given argument `$ad` is not suitable. It must be array reference.';
    }

    my $self = bless {
        list => $list,
    }, $class;

    my $lazy = defined $options && ref($options) eq 'HASH' && $options->{lazy};
    if (not $lazy) {
        $self->_construct_haystack;
    }

    return $self;
}

sub haystack {
    my ($self) = @_;

    my $haystack = $self->{haystack};
    if (defined $haystack) {
        return $haystack;
    }

    # For lazy building
    return $self->_construct_haystack;
}

sub find {
    my ($self, $needle) = @_;

    return exists($self->haystack->{$needle}) ? 1 : 0;
}

sub cnt {
    my ($self, $needle) = @_;

    return $self->haystack->{$needle} || 0;
}

sub _construct_haystack {
    my ($self) = @_;

    my %haystack;
    for my $item (@{($self->{list})}) {
        $haystack{$item}++;
    }

    $self->{haystack} = \%haystack;
}

1;
__END__

=encoding utf-8

=head1 NAME

List::Haystack - It's new $module

=head1 SYNOPSIS

    use List::Haystack;

=head1 DESCRIPTION

List::Haystack is ...

=head1 LICENSE

Copyright (C) moznion.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

moznion (E<lt>moznion@gmail.comE<gt>)

=cut

