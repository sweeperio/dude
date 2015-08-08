describe Dude::Handlers::Ping, lita_handler: true do
  it { is_expected.to route_command("ping").to(:ping) }

  it "replies with PONG" do
    send_command("ping")
    expect(replies.last).to eq("PONG")
  end
end
