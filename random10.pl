#!/usr/bin/perl

%charcat = ( 'A', 'AEIU',
             'B', 'BCDFGHJKLMNPQRSTVWXYZ',
             'a', 'aeiou',
             'b', 'bcdfghjkmnpqrstvwxyz',
             '0', '0123456789',
             '@', '!#$%&()+-*=@[]{};:<>/?.,_' ); #"

$charcat{'e'} = $charcat{'A'} . $charcat{'a'};
$charcat{'c'} = $charcat{'B'} . $charcat{'b'};
$charcat{'n'} = $charcat{'B'} . $charcat{'A'}.
                $charcat{'b'} . $charcat{'a'}.
                $charcat{'0'};
$charcat{'*'} = $charcat{'B'} . $charcat{'A'} .
                $charcat{'b'} . $charcat{'a'} .
                $charcat{'0'} . $charcat{'@'};

@template = split('-', 'cec-ece-@-@-0-0');
$nmax = (($nmax = $ARGV[0] + 0) <= 0 ? 1 : $nmax);

srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip`);

for ($i = 1; $i <= $nmax; $i++) {
    foreach $cat (split('', join('', &shuffle(@template)))) {
        print &gen_rand_c($charcat{$cat});
    }
    print "\n";
}

exit;

sub shuffle {
    local(@orig) = @_;
    local(@ret);
    while (@orig) {
        push(@ret, splice(@orig, int(rand(@orig)), 1));
    }
    @ret;
}

sub gen_rand_c {
    local($chars) = @_;
    my($len, $c);

    $c = $chars;
    $len = length($c);
    substr($chars, int(rand(length($chars))), 1);
}

