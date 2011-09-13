require 'addressable/uri'
require 'json'
require 'pry'

module Yelp
  
  class Base
    API_HOST = "api.yelp.com"
    API_PATH = "/v2"
    
    SEARCH_PATH = "#{API_PATH}/search"
    
    # Passing in the appropriate values, have access to the yelp api
    #
    # consumer_key    - A value used by the Consumer to identify itself to the Service Provider.
    # consumer_secret - A secret used by the Consumer to establish ownership of the Consumer Key.
    # token           - A value used by the Consumer to obtain authorization from the User, and exchanged for an Access Token.
    # token_secret    - A secret used by the Consumer to establish ownership of a given Token.
    #
    # Returns nothing.
    def initialize(consumer_key, consumer_secret, token, token_secret)
      @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => API_HOST})
      @access_token = OAuth::AccessToken.new(@consumer, token, token_secret)
    end
    

    # Search for a given optional term and locations
    #
    # term          - (Optional) Search term.
    # location      - Location to search
    # location_type - Location Hash continaing one of three search types.
    #
    # Example
    #   search("dinner", "san+francisco", :location)
    #   search("dinner", "34.720,-112.299", :ll)
    #
    # Returns hash of businesses found.
    def search(term, location)
      raise ArgumentError, "Location must be a hash and of size 1" unless location.is_a?(Hash) || location.size != 1
      uri = Addressable::URI.new(  
        :scheme => "http",
        :host => API_HOST,
        :path => SEARCH_PATH
      )
     
      uri.query_values = {
        :term => term
      }.merge(location)
      
      
      res = @access_token.get(uri.to_s)
      hash = JSON.parse(res.body)
      if hash["error"]
        "Sorry, #{hash["error"]["text"]}"
      else
        hash["businesses"].collect {|b| Yelp::Business.new(b)} 
      end
    end

  end

end