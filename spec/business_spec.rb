require File.dirname(__FILE__) + '/spec_helper'

describe Yelp::Business do

  use_vcr_cassette

  before do
    @base = Yelp::Base.new(
      YELP_CONSUMER_KEY,
      YELP_CONSUMER_SECRET,
      YELP_TOKEN,
      YELP_TOKEN_SECRET)
    @business = @base.search_with_location("Fountainhead", "chicago", :limit => 1).first
  end


  it "has attributes" do
    @business.id.should == "fountainhead-chicago"
    @business.name.should == "Fountainhead"
    @business.phone.should == "7736978204"
    @business.url.should == "http://www.yelp.com/biz/fountainhead-chicago"
    @business.mobile_url.should == "http://m.yelp.com/biz/F3kfPxdaTIrv49-kItDvBA"
    @business.image_url.should == "http://s3-media4.ak.yelpcdn.com/bphoto/2vblTFxqO4LPBGT5hT5CJg/ms.jpg"
    @business.review_count.should == 299
  end

  it "has a location" do
    @business.location.class == Yelp::Location
  end

  it "tests for equality" do 
    biz1 = Yelp::Business.new('id' => 'business-one')
    biz2 = Yelp::Business.new('id' => 'business-two')
  
    biz1.should_not == biz2
    biz1.should == Yelp::Business.new('id' => 'business-one')
  end

end
