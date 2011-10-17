require 'ostruct'

module Yelp

  class Business
    
    def initialize(hash)
      @hash = hash
    end

    def id
      @hash['id']
    end

    def method_missing(method, *args, &block)
      @hash[method.to_s] || super
    end

    def location
      Yelp::Location.new(@hash['location'])
    end

    def ==(other)
      id == other.id
    end

  end
  
end
