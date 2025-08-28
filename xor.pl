#!/usr/bin/env perl

@ARGV || die "require a keyfile argument";
my $keyfile = shift @ARGV;

open(my $fh, "<", $keyfile) || die "can't open `$keyfile`: $!";
my $key = do { local $/; <$fh> };
close $fh;

my $input = do { local $/; <STDIN> };

length($key) == length($input) || die "key and input should be the same length";

print($key ^ $input);
