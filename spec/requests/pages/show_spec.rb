describe "high_voltage pages" do
  describe "/about" do
    it do
      get page_path :about
      expect(response).to have_http_status(:ok)
    end
  end
end
