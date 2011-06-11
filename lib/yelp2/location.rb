module Yelp

  class Location
    
    def initialize(hash)
      @hash = hash
    end
    
    def address
      @hash["address"]
    end
    
    def display_address
      @hash["display_address"]
    end
    
    def city
      @hash["city"]
    end
    
    def state
      @hash["state_code"]
    end
    
    def postal_code
      @hash["postal_code"]
    end
    
    def country
      @hash["country_code"]
    end
    
    def latitude
      @hash["coordinate"]["latitude"]
    end
    
    def longitude
      @hash["coordinate"]["longitude"]
    end
    
    def neighborhoods
      @hash["neighborhoods"]
    end
    
  end
  
end
