source "https://rubygems.org"

gem "activesupport", "~> 4", require: "active_support/all"
gem "lita"
gem "lita-slack"

gem "octokit"

group :development, :test do
  gem "pry-byebug"
  gem "rubocop", require: false
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "webmock"
end

group :deploy do
  gem "capistrano"
  gem "capistrano-bundler"
  gem "capistrano-ejson"
end
