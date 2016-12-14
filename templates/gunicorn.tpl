bind = "unix:${path}server-${name}.sock"
logfile = "${path}log/gunicorn.log"
workers = 2
loglevel = 'info'
#daemon = True
debug = True
