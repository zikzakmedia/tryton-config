# bind = "unix:${path}server-${name}.sock"
bind = "127.0.0.1:${wsgi}"
logfile = "${path}log/gunicorn.log"
workers = 2
timeout = 300
loglevel = 'info'
#daemon = True
debug = True
