require "spec_helper"

describe Dude::Repo do
  subject { Dude::Repo.new(repo_name: "dude", branch: "master") }

  it "defaults branch to master" do
    expect(Dude::Repo.new(repo_name: "dude").branch).to eq("master")
  end

  it "sets https_url appropriately" do
    expect(subject.https_url).to eq("https://github.com/sweeperio/dude.git")
  end

  it "sets ssh_url appropriately" do
    expect(subject.ssh_url).to eq("git@github.com:sweeperio/dude.git")
  end
end
