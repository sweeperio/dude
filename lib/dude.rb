# rubocop:disable Style/ClassAndModuleChildren
module Dude
  module Handlers; end
end
# rubocop:enable Style/ClassAndModuleChildren

Dir[File.expand_path("../dude/*.rb", __FILE__)].each { |file| require file }
Dir[File.expand_path("../dude/handlers/*.rb", __FILE__)].each { |file| require file }
