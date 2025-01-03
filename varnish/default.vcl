vcl 4.0;

import std;

backend default {
    .host = "nginx";
}

sub vcl_recv {
    set req.http.X-Forwarded-For = client.ip;
    return (lookup);
}

sub vcl_hash {
    set bereq.http.host = regsub(req.http.host, "^www\.", "");
    hash_data(req.url);
}

sub vcl_fetch {
    set beresp.ttl = 1h;
    return (deliver);
}
