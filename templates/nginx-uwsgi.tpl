server {
  listen ${nginx};
  server_name ${name}.zzsaas.com;

  # Sao path
  root ${path}public_data/sao;

  index index.html index.htm;

  server_name _;
  client_max_body_size 50M;

  location / {
    include uwsgi_params;
    if ($$request_method = POST) {
      uwsgi_pass localhost:${port};
      break;
    }
    # First attempt to serve request as file, then
    # as directory, then fall back to displaying a 404.
    try_files $$uri $$uri/ =404;
  }
}
