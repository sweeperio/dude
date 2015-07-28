require "json"

class SecretsHash < Hash
  SECRETS_FILE = File.expand_path("../../config/secrets.json", __FILE__)

  class SecretNotFound < StandardError; end

  def initialize
    super { |secrets, key| raise SecretNotFound.new("Secret #{key} not found") }
  end
end

Secrets = JSON.parse(
  File.read(SecretsHash::SECRETS_FILE),
  symbolize_names: true,
  object_class: SecretsHash
)
