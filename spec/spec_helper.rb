ENV["ENV"] = "test"

require "lita/rspec"
require "webmock/rspec"
require "pry-byebug"
require File.expand_path("../../lita_config", __FILE__)

Lita.version_3_compatibility_mode = false

RSpec.configure do |config|
  config.order             = :random
  config.warnings          = true
  config.default_formatter = "doc" if config.files_to_run.one?

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def fixture_file(path)
  IO.binread(File.expand_path("../files/#{path}", __FILE__))
end
