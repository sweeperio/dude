class Dude::Handlers::Github < Lita::Handler
  http.post "/github/webhooks", :webhook

  def webhook(request, response)
    return unless verify_signature(request)

    request.body.rewind
    payload = JSON.parse(request.body.read)
    payload["event_type"] = request.env['HTTP_X_GITHUB_EVENT']
    payload = Hashie::Mash.new(payload)

    case payload.event_type
    when "deployment"
      robot.trigger(:github_deploy, payload)
    end

    robot.trigger(:github_hook, payload)
  end

  private

  def verify_signature(request)
    request.body.rewind
    body      = request.body.read
    secret    = Settings.get(:octokit, :webhook_secret)
    signature = "sha1=#{OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), secret, body)}"
    Rack::Utils.secure_compare(signature, request.env["HTTP_X_HUB_SIGNATURE"])
  end
end

Lita.register_handler(Dude::Handlers::Github)
