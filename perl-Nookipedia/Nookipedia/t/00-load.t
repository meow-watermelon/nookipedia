#!perl -T
use 5.8.8;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Nookipedia' ) || print "Bail out!\n";
}

diag( "Testing Nookipedia $Nookipedia::VERSION, Perl $], $^X" );
