class Dude::Handlers::Deploy < Lita::Handler
  route(%r{\Adeploy ([^\s\/]+(\/[^\s\/]+)?) to (staging|production)\z}, :deploy, command: true)

  def deploy(response)
    repo, branch, env = extract_repo_branch_and_env(response.matches.first)
    response.reply("deploying #{repo} (#{branch}) to #{env}")
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
