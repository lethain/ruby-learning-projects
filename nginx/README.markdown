
Write a parser which takes in a Nginx configuration ([this like this one](https://www.nginx.com/resources/wiki/start/topics/examples/full/)
and returns a useful datastructure.

A basic starting configuration to parse would be:

    server {
        listen 8080;
        root /data/default;
        location / {
            root    /data/another;
        }
    }

The interface for this should look something like:

    np = NginxParser.new
    cfg = np.parse_file('/etc/nginx/mysite')
    cfg.servers.each do |c|
      puts c
      c.locations.each do |l|
        puts l
      end
    end

Where each `Server` and `Location` exposes their
internal attributes.