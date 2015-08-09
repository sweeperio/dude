set :deploy_to, "/home/deploy/apps/dude"
set :ejson_file, "config/secrets.production.ejson"
set :ejson_output_file, "config/secrets.json"
set :ejson_deploy_mode, :remote

set :bundle_binstubs, -> { release_path.join("vendor", "bin") }
set :bundle_path, -> { release_path.join("vendor", "bundle") }
set :bundle_jobs, 4

server "dude.sweeper.io", user: "deploy", roles: %w(all)
