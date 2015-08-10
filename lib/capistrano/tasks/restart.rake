namespace :deploy do
  desc "restarts the dude service"
  task :restart_service do
    on release_roles(:all) do
      info "Restarting the service..."
      sudo "/sbin/stop dude || true" # ok if it's not running
      sudo "/sbin/start dude"
    end
  end

  after :published, :restart_service
end
