use strict;
use warnings;
use utf8;

use List::Haystack;

use Test::More;

subtest 'With a list that has any contents' => sub {
    my $haystack = List::Haystack->new([qw/foo bar foo/]);
    is $haystack->find('foo'), 1;
    is $haystack->find('bar'), 1;
    is $haystack->find('buz'), 0;
};

subtest 'With empty list' => sub {
    my $haystack = List::Haystack->new([]);
    is $haystack->find('foo'), 0;
};

done_testing;

