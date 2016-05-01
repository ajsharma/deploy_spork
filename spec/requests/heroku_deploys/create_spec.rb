describe HerokuDeploysController do
  describe "#create" do
    it "enqueues a heroku deploy job" do
      expect do
        post heroku_deploys_path
      end.to have_enqueued_job HerokuDeployJob
    end
  end
end
