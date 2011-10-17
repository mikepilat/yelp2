require File.dirname(__FILE__) + '/spec_helper'

describe Yelp::Base do
  
  context "search" do
 
    before do
      @base = Yelp::Base.new(
        YELP_CONSUMER_KEY,
        YELP_CONSUMER_SECRET,
        YELP_TOKEN,
        YELP_TOKEN_SECRET)
    end
    
    use_vcr_cassette
  
    it "fails with bad OAuth credentials" do
      base = Yelp::Base.new("bad","bad","bad","bad")
      expect { base.search_with_location("pizza", "chicago, il") }.should raise_error
    end

    context "by location" do

      it "returns businesses" do
        results = @base.search_with_location("pizza", "chicago")
        results.count.should == 20
        results.collect(&:class).uniq.first.should == Yelp::Business
      end

      it "returns an empty array when no results are found" do
        results = @base.search_with_location("askdjflasjdkfljaksldfjlkasdjlf", "chicago")
        results.count.should == 0
      end
  
    end

    context "by coordinate" do
  
      it "returns businesses" do
        results = @base.search_with_coordinates("char #4", 40.7111, -73.9565)
        results.count.should == 20
        results.first.name.should == 'Char No. 4'
        results.collect(&:class).uniq.first.should == Yelp::Business
      end

      it "returns an empty array when no results are found" do
        results = @base.search_with_coordinates("aasdfajshfdhwisahfuisafwhihaih", 40.7111, -73.9565)
        results.count.should == 0
      end

    end

    context "with options" do
  
      it "supports limit" do
        results = @base.search_with_location("pizza", "chicago", :limit => 7)
        results.count.should == 7
      end

      it "supports offset" do
        initial = @base.search_with_location("pizza", "chicago")
        offset = @base.search_with_location("pizza", "chicago", :offset => 3)
        offset[0..4].should == initial[3..7]
      end

      it "supports limit and offset" do
        initial = @base.search_with_location("pizza", "chicago")
        offset = @base.search_with_location("pizza", "chicago", :offset => 3, :limit => 4)
        offset.should == initial[3..6]
      end

    end

  end

end
