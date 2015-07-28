Dir[File.expand_path("../lib/*.rb", __FILE__)].each { |file| require file }

Lita.configure do |config|
  config.robot.name      = "dude"
  config.robot.log_level = :info
  config.robot.adapter   = :shell
end
