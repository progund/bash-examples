# Examples on how to use nc (netcat) and bash (with friends) a webserver

## Simple html with date information

`./webserver.sh | nc -l -p 8080`

You can now connect to localhost:8080 with a browser or curl:

`curl localhost:8080`


## Simple json file

`./webserver.sh test.json | nc -l -p 8080`

Note: test.json is a JSON file

You can now connect to localhost:8080 with a browser or curl:

`curl localhost:8080`

## Make the web server run for ever ... and ever

`while (true); do ./webserver-file.sh small.json | nc -l -p 8080; done`

