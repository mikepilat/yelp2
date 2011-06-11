
module Yelp

  class Business
    
    def initialize(hash)
      @hash = hash
    end
    
    def id
      @hash["id"]
    end
    
    def name
      @hash["name"]
    end
    
    def phone
      @hash["phone"]
    end
    
    def url
      @hash["url"]
    end
    
    def mobile_url
      @hash["mobile_url"]
    end
    
    def image_url
      @hash["image_url"]
    end
    
    def review_count
      @hash["review_count"]
    end
    
    def location
      Yelp::Location.new(@hash["location"])
    end
    
  end
  
end
