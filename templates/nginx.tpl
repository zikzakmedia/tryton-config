upstream app_server_${name} {
  # fail_timeout=0 means we always retry an upstream even if it failed
  # to return a good HTTP response

  # for UNIX domain socket setups
  # server unix:${path}server-${name}.sock fail_timeout=0;

  # for a TCP configuration
  server 127.0.0.1:${wsgi} fail_timeout=0;
}

server {
  listen ${nginx};
  server_name ${name}.zzsaas.com;

  # Sao path
  root ${path}public_data/sao;

  index index.html index.htm;

  client_max_body_size 50M;

  location / {
    proxy_set_header X-Forwarded-For $$proxy_add_x_forwarded_for;
    proxy_set_header Host $$http_host;
    proxy_redirect off;
    proxy_connect_timeout 300;
    proxy_send_timeout 300;
    proxy_read_timeout 300;
    send_timeout 300;
    if ($$request_method = POST) {
      proxy_pass http://app_server_${name};
      break;
    }
    # First attempt to serve request as file, then
    # as directory, then fall back to displaying a 404.
    try_files $$uri $$uri/ =404;
  }
}
