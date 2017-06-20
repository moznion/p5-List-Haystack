use strict;
use warnings;
use utf8;

use List::Haystack;

use Test::More;

subtest 'Not lazy' => sub {
    subtest 'With list that has any contents' => sub {
        my $haystack = List::Haystack->new([qw/foo bar foo/]);

        ok defined $haystack->{haystack};

        is $haystack->cnt('foo'), 2;
        is $haystack->cnt('bar'), 1;
        is $haystack->cnt('buz'), 0;
    };

    subtest 'With empty list' => sub {
        my $haystack = List::Haystack->new([]);

        ok defined $haystack->{haystack};

        is $haystack->cnt('foo'), 0;
    };
};

subtest 'Lazy' => sub {
    subtest 'With list that has any contents' => sub {
        my $haystack = List::Haystack->new([qw/foo bar foo/], {lazy => 1});

        ok not defined $haystack->{haystack};

        is $haystack->cnt('foo'), 2;

        ok defined $haystack->{haystack};

        is $haystack->cnt('bar'), 1;
        is $haystack->cnt('buz'), 0;
    };

    subtest 'With empty list' => sub {
        my $haystack = List::Haystack->new([], {lazy => 1});

        ok not defined $haystack->{haystack};

        is $haystack->cnt('foo'), 0;

        ok defined $haystack->{haystack};
    };
};

done_testing;

