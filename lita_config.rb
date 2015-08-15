require "bundler"
Bundler.require

require "octokit"
Dir[File.expand_path("../lib/*.rb", __FILE__)].each { |file| require file }

Lita.configure do |config|
  Settings.configure_lita(config)
end
