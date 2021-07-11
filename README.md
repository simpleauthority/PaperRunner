# PaperRunner
## Run a specific build or the latest build of/for a specific version inside of a Docker container

## How to use
1. Do `nano environment.properties` and configure the VERSION, BUILD, and RAM entries
2. Run `./bin/build.sh` to build the server's docker image.
3. Run `./bin/startfg.sh` to start the server in the foreground for the first time.
3. This will crash pretty quickly. `cd server_files` and then `nano eula.txt` and change the value inside from `false` to `true`.
5. Do `cd ../`
6. Run `./bin/start.sh` to start the server in the background this time.
7. Your server should now be running. Verify with `./bin/status.sh"; you should see that the service is up with the port exposed.
8. You can now use `./bin/console.sh` to use the console.
9. Stop the server with `./bin/stop.sh`
