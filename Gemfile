source "https://rubygems.org"

gem "activesupport", "~> 4", require: "active_support/all"
gem "lita"
gem "lita-slack"

gem "octokit"

group :development, :test do
  gem "pry-byebug"
  gem "rack-test"
  gem "rubocop", require: false
  gem "rspec"
end

group :deploy do
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-ejson"
end
