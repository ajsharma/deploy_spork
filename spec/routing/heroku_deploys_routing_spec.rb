RSpec.describe HerokuDeploysController do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/heroku_deploys").to route_to("heroku_deploys#create")
    end
  end
end
