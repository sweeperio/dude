RSpec.describe Secrets do
  it "can access top-level secrets" do
    expect(Secrets[:answer]).to be(42)
  end

  it "can access nested secrets by hash" do
    expect(Secrets[:nested][:works]).to be(true)
  end

  it "raises when accessing an unknown secret" do
    expect { Secrets[:wtf_is_this] }.to raise_error(SecretsHash::SecretNotFound)
  end
end
