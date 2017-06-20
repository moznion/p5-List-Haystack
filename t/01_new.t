use strict;
use warnings;
use utf8;

use List::Haystack;

use Test::More;

subtest 'Should instantiate successfully' => sub {
    subtest 'Not lazy' => sub {
        subtest 'With list that has any contents' => sub {
            ok my $obj = List::Haystack->new([qw/foo bar foo/]);
            isa_ok $obj, 'List::Haystack';

            ok defined $obj->{haystack};
            is ref $obj->{haystack}, 'HASH';
            is_deeply $obj->{haystack}, {
                foo => 2,
                bar => 1,
            };
        };

        subtest 'With empty list' => sub {
            ok my $obj = List::Haystack->new([]);
            isa_ok $obj, 'List::Haystack';

            ok defined $obj->{haystack};
            is ref $obj->{haystack}, 'HASH';
            is_deeply $obj->{haystack}, {};
        };
    };

    subtest 'Lazy' => sub {
        subtest 'With list that has any contents' => sub {
            ok my $obj = List::Haystack->new([qw/foo bar foo/], {lazy => 1});
            isa_ok $obj, 'List::Haystack';

            ok not defined $obj->{haystack};
        };

        subtest 'With empty list' => sub {
            ok my $obj = List::Haystack->new([], {lazy => 1});
            isa_ok $obj, 'List::Haystack';

            ok not defined $obj->{haystack};
        };
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

