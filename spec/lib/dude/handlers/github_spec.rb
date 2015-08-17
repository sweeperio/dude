require "spec_helper"

describe Dude::Handlers::Github, lita_handler: true do
  it "does things" do
    http.post("/github/webhooks")
    expect(true).to be true
  end
end
