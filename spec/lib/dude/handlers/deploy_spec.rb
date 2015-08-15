require "spec_helper"

describe Dude::Handlers::Deploy, lita_handler: true do
  before do
    stub_request(:get, %r{https://api.github.com/repos/sweeperio/dude/commits/.*/status}).to_return(
      status: 200,
      body: fixture_file("status_stub.json"),
      headers: { "Content-Type" => "application/json" }
    )
  end

  context "#deploy" do
    [
      "deploy dude to staging",
      "deploy dude/master to production",
      "deploy dude/some-branch to production"
    ].each do |command|
      it { is_expected.to route_command(command).to(:deploy) }
    end

    [
      "deploy to production",
      "deploy dude/master to badenv",
      "deploy dude production",
      "deploy dude/test/branch-name to staging"
    ].each do |command|
      it { is_expected.to_not route_command(command) }
    end

    it "extracts repo name and environment from the command" do
      send_command("deploy dude to production")
      expect(replies).to include("deploying dude/master (6dcb09b) to production")
    end

    it "extracts repo name, branch name and environment from the command" do
      send_command("deploy dude/my-feature-branch to production")
      expect(replies).to include("deploying dude/my-feature-branch (6dcb09b) to production")
    end

    it "doesn't trigger the deploy if the target is not deployable (failed CI, etc)" do
      expect_any_instance_of(Dude::Repo).to receive(:deployable?).and_return(false)
      send_command("deploy dude to production")
      expect(replies).to include("Oops! I can't deploy dude/master (6dcb09b). CI still running?")
    end

    it "triggers a deploy on the repo" do
      expect_any_instance_of(Dude::Repo).to receive(:deploy)
      send_command("deploy dude to production")
    end
  end
end
