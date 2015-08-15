require "spec_helper"

describe Dude::Repo do
  subject { Dude::Repo.new(repo_name: "dude", branch: "master") }

  before do
    stub_request(:get, "https://api.github.com/repos/sweeperio/dude/commits/master/status").to_return(
      status: 200,
      body: fixture_file("status_stub.json"),
      headers: { "Content-Type" => "application/json" }
    )
  end

  it "defaults branch to master" do
    expect(Dude::Repo.new(repo_name: "dude").branch).to eq("master")
  end

  it "sets https_url appropriately" do
    expect(subject.https_url).to eq("https://github.com/sweeperio/dude.git")
  end

  it "sets ssh_url appropriately" do
    expect(subject.ssh_url).to eq("git@github.com:sweeperio/dude.git")
  end

  it "fetches status from GitHub" do
    expect(subject.status.state).to eq("success")
  end

  context "#deployable?" do
    it "is true when the state is success" do
      expect(subject.deployable?).to be true
    end

    it "is false when the state is not success" do
      expect(subject.status).to receive(:state).and_return("failed")
      expect(subject.deployable?).to_not be true
    end
  end
end
