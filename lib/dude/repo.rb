class Dude::Repo
  OWNER = "sweeperio".freeze

  attr_reader :repo_name, :branch, :full_name
  attr_reader :https_url, :ssh_url

  def initialize(repo_name:, branch: "master")
    @repo_name = repo_name
    @branch    = branch
    @full_name = "#{OWNER}/#{repo_name}"
    @https_url = "https://github.com/#{full_name}.git"
    @ssh_url   = "git@github.com:#{full_name}.git"
  end

  def deploy(user:, env: "production")
    api.create_deployment(
      full_name,
      branch,
      auto_merge: false,
      environment: env,
      payload: JSON.generate(deploy_user: user, environment: env),
      description: "deploy triggered by dude"
    )
  end

  def status
    @status ||= api.status(full_name, branch)
  end

  def sha
    @sha ||= `git rev-parse --short #{status.sha}`.chomp
  end

  private

  def api
    @api ||= Octokit::Client.new(access_token: Settings.get(:octokit, :token))
  end
end
