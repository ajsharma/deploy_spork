describe DeploymentNotification do
  let(:deployment_notification) { described_class.new }
  subject { deployment_notification }

  describe "#notify" do
    it "sends a get" do
      expect(subject.notify).to be
    end
  end
end
