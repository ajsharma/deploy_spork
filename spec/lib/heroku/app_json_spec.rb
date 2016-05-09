describe "Heroku app.json" do
  let(:app_json_file_path) { File.join(Rails.root, "app.json") }
  let(:app_json_file) { File.read(app_json_file_path) }
  let(:app_json) { JSON.parse(app_json_file) }

  let(:dot_env_file_path) { File.join(Rails.root, ".env") }
  let(:dot_env_file) { File.read(dot_env_file_path) }
  let(:dot_env) { YAML.parse(dot_env_file) }

  it do
    expect(File.exist?(app_json_file_path)).to be_truthy
  end

  it do
    expect(app_json.keys).to contain_exactly(
      "description",
      "env",
      "keywords",
      "logo",
      "name",
      "repository",
      "scripts",
      "success_url",
      "website",
    )
  end

  describe "the ENV keys" do
    it do
      expect(app_json["env"].keys).to contain_exactly(
        "DOMAIN_NAME",
        "RAILS_ENV",
        "SECRET_TOKEN"
      )
    end
  end
end
