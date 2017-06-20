use strict;
use warnings;
use utf8;

use List::Haystack;

use Test::More;

subtest 'Not lazy' => sub {
    subtest 'With a list that has any contents' => sub {
        my $haystack = List::Haystack->new([qw/foo bar foo/]);

        ok defined $haystack->{haystack};

        is $haystack->find('foo'), 1;
        is $haystack->find('bar'), 1;
        is $haystack->find('buz'), 0;
    };

    subtest 'With empty list' => sub {
        my $haystack = List::Haystack->new([]);

        ok defined $haystack->{haystack};

        is $haystack->find('foo'), 0;
    };
};

subtest 'Lazy' => sub {
    subtest 'With a list that has any contents' => sub {
        my $haystack = List::Haystack->new([qw/foo bar foo/], {lazy => 1});

        ok not defined $haystack->{haystack};

        is $haystack->find('foo'), 1;

        ok defined $haystack->{haystack};

        is $haystack->find('bar'), 1;
        is $haystack->find('buz'), 0;
    };

    subtest 'With empty list' => sub {
        my $haystack = List::Haystack->new([], {lazy => 1});

        ok not defined $haystack->{haystack};

        is $haystack->find('foo'), 0;

        ok defined $haystack->{haystack};
    };
};

done_testing;

