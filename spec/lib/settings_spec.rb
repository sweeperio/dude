RSpec.describe Settings do
  subject do
    Class.new do
      attr_accessor :name, :robot, :secret

      def initialize
        @robot = OpenStruct.new(name: nil)
      end
    end
  end

  context ".configure_lita" do
    before(:each) { Settings.configure_lita(config) }
    let(:config)  { subject.new }

    it "assigns values to simple properties" do
      expect(config.name).to eq("test")
    end

    it "assigns attributes to children" do
      expect(config.robot.name).to eq("dude")
    end

    it "assigns attributes from Secrets[:lita] as well" do
      expect(config.secret).to eq("known")
    end
  end

  context ".get" do
    it "returns the setting value" do
      expect(Settings.get(:name)).to eq("test")
    end

    it "returns nested settings" do
      expect(Settings.get(:robot, :name)).to eq("dude")
    end
  end
end
