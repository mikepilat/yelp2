require 'addressable/uri'
require 'json'

module Yelp
  
  class Base
    API_HOST = "api.yelp.com"
    API_PATH = "/v2"
    
    SEARCH_PATH = "#{API_PATH}/search"
    
    # Initializes the base object through which you access the Yelp API. 
    #
    # Obtain API access here: http://www.yelp.com/developers/getting_started/api_access
    #
    # +consumer_key+    - OAuth2 Consumer Key 
    # +consumer_secret+ - OAuth2 Consumer Secret
    # +token+           - OAuth2 Access Token
    # +token_secret+    - OAuth2 Access Secret
    def initialize(consumer_key, consumer_secret, token, token_secret)
      @consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => API_HOST})
      @access_token = OAuth::AccessToken.new(@consumer, token, token_secret)
    end
    

    # Search for businesses near a given location
    #
    # +term+ - The search term
    # +location+ - The location to search
    #
    #   search_by_location("dinner", "san+francisco")
    #
    # Returns an array of Yelp::Business objects
    def search_with_location(term, location, options={})
      search_businesses(term, options.merge(:location => location))
    end

    # Search for businesses near the given coordinates
    #
    # +term+ - The search term
    # +latitute+ - The latitude in decimal degrees
    # +longitude+ - The longitude in decimal degrees
    # 
    def search_with_coordinates(term, latitude, longitude, options={})
      search_businesses(term, options.merge(:ll=>"#{latitude},#{longitude}"))
    end

    private 
    
    def search_businesses(term, options)
      uri = Addressable::URI.new(  
        :scheme => "http",
        :host => API_HOST,
        :path => SEARCH_PATH)
     
      uri.query_values = {
        :term => term,
      }.merge(options.inject({}){|h,(k,v)| h[k] = v.to_s; h})

      res = @access_token.get(uri.to_s)
      hash = JSON.parse(res.body)
      if hash["error"]
        raise hash["error"]["text"]
      else
        hash["businesses"].collect {|b| Yelp::Business.new(b)} 
      end
    end

  end

end
