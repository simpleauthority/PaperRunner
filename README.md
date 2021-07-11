# PaperRunner
## Run a specific build or the latest build of/for a specific version inside of a Docker container.

## How to use
1. Do `nano ./environment` and configure the VERSION, BUILD, and RAM entries.
2. Run `./bin/build.sh` to build the server's docker image.
3. Run `./bin/start.sh` to start the server, followed by `./bin/console.sh` to bring it into the foreground.
4. This should crash complaining about the EULA. Good.
5. Do `cd server_files` and then `nano eula.txt` and change the value inside from `false` to `true`. Do `cd ../` to return to the prior directory.
6. Run `./bin/start.sh` to start the server in the background.
7. Your server should now be running. Verify with `./bin/status.sh`; you should see that the service is up with the port exposed.
8. You can now use `./bin/console.sh` to use the console.
9. When you're done using the console, try `CTRL+P+Q`. You do that by typing `CTRL+P`, let go of `P` (keep `CTRL` down) then press `Q`. **DO NOT** use `CTRL+C`. This will kill the server.
10. Stop the server with `./bin/console.sh` and then typing `stop`.

## Scripts
- `./bin/build.sh` - alias for `docker-compose build --no-cache paper` - rebuilds the image; used if `environment`, `docker-compose.yml` or `Dockerfile` are changed
- `./bin/console.sh` - alias for `docker attach paper` - attaches to the container stdout and stdin so as to allow you to interact with Paper directly
- `./bin/flogs.sh` - alias for `docker-compose logs -f paper` - attaches to the container logs and continues following them for new logs
- `./bin/logs.sh` - alias for `docker-compose logs paper` - prints all current container logs and then exits
- `./bin/start.sh` - alias for `docker-compose up -d paper` - brings the container up, recreating the container if `./bin/build.sh` was run prior
- `./bin/status.sh` - alias for `docker-compose ps paper` - brings up status information about the paper container

## Tips
- If you want to start the server and watch the entire startup process, you can do one of these:
  1. Run `./bin/start.sh` and then immediately run `./bin/flogs.sh` -- this will give you a noninteractive view of the server startup process
  2. Run `./bin/start.sh` and then immediately run `./bin/console.sh` -- this will give you an interactive view of the server startup process

- If you are viewing the console, exit it by typing `CTRL+P+Q`. First type `CTRL+P`, then let go of `P` and press `Q`.
