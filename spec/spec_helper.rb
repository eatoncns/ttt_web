ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'rspec-html-matchers'

$: << File.join(File.dirname(__FILE__), '..')

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include Rack::Test::Methods
  config.include RSpecHtmlMatchers
end

RSpec::Matchers.define(:redirect_to) do |path|
  match do |response|
    uri = URI.parse(response.headers['Location'])
    response.status / 100 == 3 && uri.path == path
  end
end
