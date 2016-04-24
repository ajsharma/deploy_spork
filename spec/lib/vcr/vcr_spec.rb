describe VCR do
  describe "automatic VCR cassettes" do
    it "captures " do
      expect { HTTParty.get "http://www.example.com" }.not_to raise_error
    end

    it "can optionally be disabled", vcr: { record: :skip } do
      expect(true).to be_truthy
    end
  end
end
