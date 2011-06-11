require 'addressable/uri'
require 'json'

module Yelp
  
  class Base
    API_HOST = "api.yelp.com"
    API_PATH = "/v2"
    
    SEARCH_PATH = "#{API_PATH}/search"
    
    def initialize(consumer_key, consumer_secret, token, token_secret)
      @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => API_HOST})
      @access_token = OAuth::AccessToken.new(@consumer, token, token_secret)
    end
    
    def search(term, latitude, longitude)
      uri = Addressable::URI.new(  
        :scheme => "http",
        :host => API_HOST,
        :path => SEARCH_PATH
      )
      
      uri.query_values = {
        :term => term,
        :ll => "#{latitude.to_s},#{longitude.to_s}"
      }
      
      res = @access_token.get(uri.to_s)
      
      hash = JSON.parse(res.body)  
      hash["businesses"].collect {|b| Yelp::Business.new(b)}
    end
    
  end

end