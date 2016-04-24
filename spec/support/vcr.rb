require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
  config.default_cassette_options = {
    record: (ENV["CI"] == "true" ? :none : :once)
  }
end

RSpec.configure do |config|
  # Add VCR to all tests
  # Skip VCR using the tag combo: `vcr: { record: :skip }`
  config.around :each do |example|
    options = example.metadata[:vcr] || {}

    if options[:record] == :skip
      VCR.turned_off(&example)
    else
      beginning_of_name =
        example.metadata[:file_path].
        sub("./spec", "").
        sub("_spec.rb", "")

      end_of_name =
        example.metadata[:full_description].
        split(/\s+/, 2).
        join("/").
        underscore.
        tr("#", "/"). # so describe "#my_method" generates a folder
        tr(".", "/").
        gsub(%r{[^\w\/]+}, "_").
        gsub(%r{\/$}, "")

      name = [beginning_of_name, end_of_name].join("/")

      VCR.use_cassette name, options, &example
    end
  end
end
