class Dude::Handlers::Deploy < Lita::Handler
  route(%r{\Adeploy ([^\s\/]+(\/[^\s\/]+)?) to (staging|production)\z}, :deploy, command: true)

  def deploy(response)
    repo_name, branch, env = extract_repo_branch_and_env(response.matches.first)
    repo = Dude::Repo.new(repo_name: repo_name, branch: branch)

    unless repo.deployable?
      response.reply("Oops! I can't deploy #{repo_name}/#{branch} (#{repo.sha}). CI still running?")
      return
    end

    response.reply("deploying #{repo_name}/#{branch} (#{repo.sha}) to #{env}")
    repo.deploy
  end

  private

  def extract_repo_branch_and_env(match)
    repo, branch, env = match
    repo = repo.split("/").first unless branch.nil?
    branch ||= "/master"

    [repo, branch[1..-1], env]
  end
end

Lita.register_handler(Dude::Handlers::Deploy)
