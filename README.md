# PaperRunner
## Run a specific build or the latest build of/for a specific version inside of a Docker container.

## How to use
1. Do `nano ./environment` and configure the VERSION, BUILD, and RAM entries.
2. Run `./bin/build.sh` to build the server's docker image.
3. Run `./bin/start.sh` to start the server, followed by `./bin/console.sh` to bring it into the foreground.
4. This should crash complaining about the EULA. Good.
5. Do `cd server_files` and then `nano eula.txt` and change the value inside from `false` to `true`. Do `cd ../` to return to the prior directory.
6. Run `./bin/start.sh` to start the server in the background.
7. Your server should now be running. Verify with `./bin/status.sh"; you should see that the service is up with the port exposed.
8. You can now use `./bin/console.sh` to use the console.
9. When you're done using the console, try CTRL+P+Q. You do that by typing CTRL+P, let go of P (keep CTRL down) then press Q. DO NOT use CTRL+C. This will kill the server.
10. Stop the server with `./bin/console.sh` and then typing `stop`.
