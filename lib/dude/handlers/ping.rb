class Dude::Handlers::Ping < Lita::Handler
  route(/\Aping\z/, :ping, command: true, help: { "ping" => "Reply with PONG" })

  def ping(response)
    response.reply("PONG")
  end
end

Lita.register_handler(Dude::Handlers::Ping)
