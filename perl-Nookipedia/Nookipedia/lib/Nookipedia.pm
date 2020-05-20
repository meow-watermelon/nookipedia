package Nookipedia;

use strict;
use warnings;

our @EXPORT_OK = qw(get_today get_villager get_villager_all get_villager_detail get_fossil get_fossil_detail);
our %EXPORT_TAGS = ( all => \@EXPORT_OK );
use base qw(Exporter);

our $VERSION = '0.0.1';

use LWP::UserAgent;
use LWP::Protocol::https;
use JSON qw(decode_json);

sub http_client {
    my ($apikey, $url) = @_;
    my $ref = {};

    my $call = LWP::UserAgent->new(
        timeout => 30,
    );

    $call->default_header('X-API-Key' => $apikey);

    my $response = $call->get($url);

    if ($response->is_success) {
        $ref = decode_json($response->decoded_content);
    }

    return $ref;
}

sub get_today {
    my ($apikey, $url) = ($_[0], 'https://nookipedia.com/api/today/');
    return http_client($apikey, $url);
}

sub get_villager {
    my ($apikey, $url) = ($_[0], 'https://nookipedia.com/api/villager/');
    return http_client($apikey, $url);
}

sub get_villager_all {
    my ($apikey, $url) = ($_[0], 'https://nookipedia.com/api/villager/all/');
    return http_client($apikey, $url);
}

sub get_villager_detail {
    my ($apikey, $name) = ($_[0], $_[1]);
    my $url = "https://nookipedia.com/api/villager/$name/";
    return http_client($apikey, $url);
}

sub get_critter {
    # listing-all for critter is not supported yet by vendor.
    # placeholder
}

sub get_fossil {
    my ($apikey, $url) = ($_[0], 'https://nookipedia.com/api/fossil/');
    return http_client($apikey, $url);
}

sub get_fossil_detail {
    my ($apikey, $name) = ($_[0], $_[1]);
    my $url = "https://nookipedia.com/api/fossil/$name/";
    return http_client($apikey, $url);
}

# default return value
1;

__END__

=pod

=head1 NAME

Nookipedia - A simple wrapper for Nookipedia API

=head1 VERSION

version 0.0.1

=head1 SYNOPSIS

    use Nookipedia qw(:all);
    
    my $apikey = 'AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE';
    
    # return today endpoint
    my $today_ref = get_today($apikey);
    
    # return villager endpoint
    my $villager_ref = get_villager($apikey);
    
    # return villager listing-all endpoint
    my $villager_all_ref = get_villager_all($apikey);
    
    # return a specific villager detail
    my $villager_detail_ref = get_villager_detail($apikey, 'Walker'));
    
    # return fossil endpoint
    my $fossil_ref = get_fossil($apikey));
    
    # return a specific fossil detail
    my $fossil_detail_ref = get_fossil_detail($apikey, 'Pachycephalosaurus');

=head1 DESCRIPTION

Nookipedia is a small and simple wrapper to access Nookipedia API endpoints. For each subroutine it returns a scalar reference. If the module cannot get the data from the vendor API server, it returns an empty hash reference.

=head1 EXPORT

Nothing is exported by default. You can ask for specific subroutines (described below) or ask for all subroutines at once:

    use Nookipedia qw(get_today get_villager get_villager_all ...);

    # or

    use Nookipedia qw(:all);

=head1 SUBROUTINES

=head2 get_today($apikey)

Return a scalar reference from the /today endpoint. Date option is not supported yet.

=head2 get_villager($apikey)

Return a scalar reference from the /villager endpoint. This subroutine only returns the villagers list with Wiki/API URLs.

=head2 get_villager_all($apikey)

Return a detailed listing-all scalar reference from the /villager/all endpoint. If you would like to get the details of all villagers in one reference, this would be the best approach.

=head2 get_villager_detail($apikey, $name)

Return a detailed scalar reference for a specific villager from the /villager/$name endpoint.

=head2 get_fossil($apikey)

Return a scalar reference from the /fossil endpoint. This subroutine only returns the fossils list with Wiki/API URLs.

=head2 get_fossil_detail($apikey, name)

Return a detailed scalar reference for a specific fossil from the /fossil/$name endpoint.

=head1 BUGS

=over 4

=item *

B</critter> endpoint wrapper is not supported yet in this module.

=item *

B</today> endpoint does not support date option. Which means, it only returns the present day event and details.

=item *

This module does not return non-English UTF-8 characters. Instead, user has to process the UTF-8 presented data separately.

=back

=head1 AUTHOR

=over 4

=item *

Hui Li <herdingcat@yahoo.com>

=back

=head1 LICENSE

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
