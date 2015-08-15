class Dude::Repo
  attr_reader :repo_name, :branch

  def initialize(repo_name:, branch: "master")
    @repo_name = repo_name
    @branch    = branch
  end

  def https_url
    @https_url ||= "https://github.com/sweeperio/#{repo_name}.git"
  end

  def ssh_url
    @ssh_url ||= "git@github.com:sweeperio/#{repo_name}.git"
  end
end
