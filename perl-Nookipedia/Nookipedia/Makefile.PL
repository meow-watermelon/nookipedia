use 5.8.8;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Nookipedia',
    AUTHOR           => q{Hui Li <herdingcat@yahoo.com>},
    VERSION_FROM     => 'lib/Nookipedia.pm',
    ABSTRACT_FROM    => 'lib/Nookipedia.pm',
    LICENSE          => 'artistic_2',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.8.8',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        'LWP::UserAgent'       => '6.02',
        'LWP::Protocol::https' => '6.02',
        'JSON'                 => '1.99_01',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Nookipedia-*' },
);
