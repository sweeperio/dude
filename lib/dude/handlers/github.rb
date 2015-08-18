class Dude::Handlers::Github < Lita::Handler
  http.post "/github/webhooks", :webhook

  on :github_deploy, :start_deploy

  def webhook(request, response)
    case request.env['HTTP_X_GITHUB_EVENT']
    when "deployment"
      robot.trigger(:github_deploy, "Deployment received")
    end

    robot.trigger(:github_deploy, "received GH notification")
  end

  def start_deploy(message)
    room   = Lita::Room.find_by_name("general")
    target = Lita::Source.new(room: room)
    robot.send_message(target, message)
  end

  private

  def announce(message)
  end
end

Lita.register_handler(Dude::Handlers::Github)
