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

  it "sets full_name to the full repo name" do
    expect(subject.full_name).to eq("sweeperio/dude")
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

  context "#deploy" do
    it "creates a deployment on GitHub" do
      expect_any_instance_of(Octokit::Client).to receive(:create_deployment).with(
        "sweeperio/dude",
        "master",
        auto_merge: false,
        environment: "production",
        payload: JSON.generate(deploy_user: "pseudomuto", environment: "production"),
        description: "deploy triggered by dude"
      )

      subject.deploy(user: "pseudomuto")
    end
  end
end
