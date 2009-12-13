package Communicator;


use Moose;

use JSON;
use LWP;
use PGBench::Config;

has 'LWP' => (is => 'ro', isa => 'LWP::UserAgent', required => 1, lazy_build => 1);


sub _build_LWP {
    my $self = shift;

    return  LWP::UserAgent->new;
}

sub pull_data {
    my ($self, $uri) = @_;

    $uri =~ s/CLIENT/$Config::opt{'myname'}/g;

    return $self->_do_request('GET', $uri);
}


sub _do_request {
    my ($self, $request, $uri, $data) = @_;

    my $req = HTTP::Request->new($request => $Config::opt{'communication_url'} . $uri);

    my $res = $self->LWP->request($req);

    if ($res->is_success) {

        # All Data is encapsulated in a helper key called "JSON"
        return (from_json($res->content))->{'JSON'};
    }
    else {
        confess "Request failed: " . $res->code . " Content:\n\n" . $res->content;
        return;
    }
}

1;
