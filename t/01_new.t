use strict;
use warnings;
use utf8;

use List::Haystack;

use Test::More;

subtest 'Should instantiate successfully' => sub {
    subtest 'With list that has any contents' => sub {
        ok my $obj = List::Haystack->new([qw/foo bar/]);
        isa_ok $obj, 'List::Haystack';
    };

    subtest 'With empty list' => sub {
        ok my $obj = List::Haystack->new([]);
        isa_ok $obj, 'List::Haystack';
    };
};

subtest 'Should fail instantiate' => sub {
    subtest 'With empty argument' => sub {
        eval {
            List::Haystack->new();
        };
        ok $@;
        like $@, qr/Argument `\$ad` is missing[.] It is a mandatory argument[.]/;
    };

    subtest 'With invalid type argument' => sub {
        eval {
            List::Haystack->new('INVALID TYPE');
        };
        ok $@;
        like $@, qr/Type of given argument `\$ad` is not suitable[.] It must be array reference[.]/;
    };
};

done_testing;

