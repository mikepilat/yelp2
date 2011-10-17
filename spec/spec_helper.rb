require 'yelp2'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.default_cassette_options = { :record => :new_episodes }
  c.stub_with :fakeweb
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end

begin
  require File.dirname(__FILE__)+"/api_config.rb"
rescue LoadError
  YELP_CONSUMER_KEY = "CONSUMER_KEY"
  YELP_CONSUMER_SECRET = "CONSUMER_SECRET"
  YELP_TOKEN = "TOKEN"
  YELP_TOKEN_SECRET = "TOKEN_SECRET"
end

