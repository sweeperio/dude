class Dude::Handlers::Github < Lita::Handler
  http.post "/github/webhooks", :webhook

  def webhook(request, response)
    case request.env['HTTP_X_GITHUB_EVENT']
    when "deployment"
      announce("Deployment received")
    end

    announce(request.body)
  end

  private

  def announce(message)
    room   = Lita::Room.find_by_name("general")
    target = Lita::Source.new(room: room)
    robot.send_message(target, message)
  end
end

Lita.register_handler(Dude::Handlers::Github)