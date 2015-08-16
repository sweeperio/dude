class Settings
  CONFIG_PATH = Pathname.new(File.expand_path("../../config", __FILE__))

  class << self
    def get(*names)
      names.inject(settings) { |config, key| config.fetch(key) }
    end

    def configure_lita(config, values: settings[:lita])
      values.each do |key, value|
        if value.is_a?(Hash)
          configure_lita(config.public_send(key), values: value)
        else
          config.public_send("#{key}=", value) if config.respond_to?("#{key}=")
        end
      end
    end

    private

    def settings
      @settings ||= begin
        env = ENV["ENV"] || "development"
        settings = if env == "test"
                     load_file("settings.example.yml")
                   else
                     load_file("settings.yml")
                   end

        settings = (settings[env] || {}).with_indifferent_access
        settings.deep_merge(Secrets)
      end
    end

    def load_file(name)
      file = CONFIG_PATH.join(name)
      return {} unless file.exist?

      YAML.load(file.read) || {}
    end
  end
end
