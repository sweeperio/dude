class Dude::Repo
  OWNER = "sweeperio".freeze

  attr_reader :repo_name, :branch

  def initialize(repo_name:, branch: "master")
    @repo_name = repo_name
    @branch    = branch
  end

  def https_url
    @https_url ||= "https://github.com/#{OWNER}/#{repo_name}.git"
  end

  def ssh_url
    @ssh_url ||= "git@github.com:#{OWNER}/#{repo_name}.git"
  end

  def status
    @status ||= begin
      client = Octokit::Client.new(access_token: Settings.get(:octokit, :token))
      client.status("#{OWNER}/#{repo_name}", branch)
    end
  end

  def deployable?
    status.state == "success"
  end
end
