class Dude::Handlers::Deploy < Lita::Handler
  route(%r{\Adeploy ([^\s\/]+(\/[^\s\/]+)?) to (staging|production)\z}, :deploy, command: true)

  def deploy(response)
    repo_name, branch, env = extract_repo_branch_and_env(response.matches.first)
    repo = Dude::Repo.new(repo_name: repo_name, branch: branch)

    response.reply("deploying #{repo_name}/#{branch} (#{repo.sha}) to #{env}")
    repo.deploy(user: response.user.name, env: env)
  rescue Octokit::Conflict => conflict
    response.reply(status_error_message(conflict, sha: repo.sha, env: env))
  end

  private

  def extract_repo_branch_and_env(match)
    repo, branch, env = match
    repo = repo.split("/").first unless branch.nil?
    branch ||= "/master"

    [repo, branch[1..-1], env]
  end

  def status_error_message(exception, sha:, env:)
    states = exception.errors.first.fetch(:contexts).map do |ctx|
      "> `#{ctx.fetch(:state)}` - *#{ctx.fetch(:context)}*"
    end

    ["*ERROR DEPLOYING #{sha} to #{env}*", *states].join("\n")
  end
end

Lita.register_handler(Dude::Handlers::Deploy)
