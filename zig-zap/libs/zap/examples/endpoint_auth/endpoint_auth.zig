const std = @import("std");
const zap = @import("zap");

const a = std.heap.page_allocator;
const token = "ABCDEFG";

const HTTP_RESPONSE: []const u8 =
    \\ <html><body>
    \\   Hello from ZAP!!!
    \\ </body></html>
;

// authenticated requests go here
fn endpoint_http_get(e: *zap.SimpleEndpoint, r: zap.SimpleRequest) void {
    _ = e;
    r.sendBody(HTTP_RESPONSE) catch return;
}

// just for fun, we also catch the unauthorized callback
fn endpoint_http_unauthorized(e: *zap.SimpleEndpoint, r: zap.SimpleRequest) void {
    _ = e;
    r.setStatus(.unauthorized);
    r.sendBody("UNAUTHORIZED ACCESS") catch return;
}

pub fn main() !void {
    // setup listener
    var listener = zap.SimpleEndpointListener.init(
        a,
        .{
            .port = 3000,
            .on_request = null,
            .log = true,
            .max_clients = 10,
            .max_body_size = 1 * 1024,
        },
    );
    defer listener.deinit();

    // create mini endpoint
    var ep = zap.SimpleEndpoint.init(.{
        .path = "/test",
        .get = endpoint_http_get,
        .unauthorized = endpoint_http_unauthorized,
    });

    // create authenticator
    const Authenticator = zap.BearerAuthSingle;
    var authenticator = try Authenticator.init(a, token, null);
    defer authenticator.deinit();

    // create authenticating endpoint
    const BearerAuthEndpoint = zap.AuthenticatingEndpoint(Authenticator);
    var auth_ep = BearerAuthEndpoint.init(&ep, &authenticator);

    try listener.addEndpoint(auth_ep.getEndpoint());

    listener.listen() catch {};
    std.debug.print(
        \\ Run the following:
        \\ 
        \\ curl http://localhost:3000/test -i -H "Authorization: Bearer ABCDEFG" -v
        \\ curl http://localhost:3000/test -i -H "Authorization: Bearer invalid" -v
        \\
        \\ and see what happens
        \\
    , .{});

    // start worker threads
    zap.start(.{
        .threads = 1,
        .workers = 1,
    });
}
