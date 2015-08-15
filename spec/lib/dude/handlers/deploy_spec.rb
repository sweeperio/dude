require "spec_helper"

describe Dude::Handlers::Deploy, lita_handler: true do
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
      expect(replies).to include("deploying dude (master) to production")
    end

    it "extracts repo name, branch name and environment from the command" do
      send_command("deploy dude/my-feature-branch to production")
      expect(replies).to include("deploying dude (my-feature-branch) to production")
    end
  end
end
