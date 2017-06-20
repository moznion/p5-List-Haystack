use strict;
use warnings;
use utf8;

use List::Haystack;

use Test::More;

subtest 'With list that has any contents' => sub {
    my $haystack = List::Haystack->new([qw/foo bar foo/]);
    is $haystack->cnt('foo'), 2;
    is $haystack->cnt('bar'), 1;
    is $haystack->cnt('buz'), 0;
};

subtest 'With empty list' => sub {
    my $haystack = List::Haystack->new([]);
    is $haystack->cnt('foo'), 0;
};

done_testing;

