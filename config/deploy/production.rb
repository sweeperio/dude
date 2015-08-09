set :deploy_to, "/home/deploy/apps/dude"
set :ejson_file, "config/secrets.production.ejson"
set :ejson_output_file, "config/secrets.json"
set :ejson_deploy_mode, :remote

server "dude.sweeper.io", user: "deploy", roles: %w(all)
