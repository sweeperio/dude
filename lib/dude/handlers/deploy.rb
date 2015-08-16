class Dude::Handlers::Deploy < Lita::Handler
  template_root File.expand_path("../../../../templates/deploy", __FILE__)

  route(%r{\Adeploy ([^\s\/]+(\/[^\s\/]+)?) to (staging|production)\z}, :deploy, command: true)
  route(%r{\A(list )?deploys for ([^\s\/]+)\z}, :list_deploys, command: true)

  def deploy(response)
    repo_name, branch, env = extract_repo_branch_and_env(response.matches.first)
    repo = Dude::Repo.new(repo_name: repo_name, branch: branch)

    response.reply("deploying #{repo_name}/#{branch} (#{repo.sha}) to #{env}")
    repo.deploy(user: response.user.mention_name, env: env)
  rescue Octokit::Conflict => conflict
    response.reply(render_template("deploy_creation_failed", repo: repo, env: env, exception: conflict))
  end

  def list_deploys(response)
    repo     = Dude::Repo.new(repo_name: response.match_data.to_a.last)
    deploys  = repo.deploys.map { |deploy| deploy_summary(deploy) }

    response.reply(render_template("list", repo: repo, deploys: deploys))
  end

  private

  def extract_repo_branch_and_env(match)
    repo, branch, env = match
    repo = repo.split("/").first unless branch.nil?
    branch ||= "/master"

    [repo, branch[1..-1], env]
  end

  def deploy_summary(deploy)
    OpenStruct.new(
      at: deploy.created_at.in_time_zone("Eastern Time (US & Canada)"),
      environment: deploy.environment,
      ref: deploy.ref,
      sha: deploy.sha,
      url: deploy.url,
      user: deploy_user(deploy)
    )
  end

  def deploy_user(deploy)
    JSON.parse(deploy.payload.to_s).fetch("deploy_user")
  rescue JSON::ParserError
    "Unknown"
  end
end

Lita.register_handler(Dude::Handlers::Deploy)
