require 'spec_helper'

describe "Arguments" do
  it "series can accept an array of hashes" do
    ZeroFill.by_date(series_array_of_hashes).count.should == 6
  end

  it "series can accept a hash of key/value pairs" do
    ZeroFill.by_date(series_hash).count.should == 6
  end

  it "should return an empty hash/array if it receives an empty series" do
    ZeroFill.by_date({}).should == {}
    ZeroFill.by_date([]).should == []
    ZeroFill.by_date([], :start_at => Date.today).should == []
    ZeroFill.by_date([], :end_at => Date.today).should == []
  end

  it "should reject invalid series input" do
    expect { ZeroFill.by_date([["herp"]]) }.to raise_exception TypeError
    expect { ZeroFill.by_date([{:herp => "derp"}]) }.to raise_exception TypeError
  end

end

describe "Results" do
  it "should properly sort dates ascending (default behavior)" do
    ZeroFill.by_date(series_array_of_hashes).map{|hash| hash[:date].to_s }.should == [
      "2013-07-27", "2013-07-28", "2013-07-29", "2013-07-30", "2013-07-31", "2013-08-01"
    ]
    ZeroFill.by_date(series_hash).keys.map(&:to_s).should == [
      "2013-07-27", "2013-07-28", "2013-07-29", "2013-07-30", "2013-07-31", "2013-08-01"
    ]
  end

  it "should return values for each date" do
    series = ZeroFill.by_date(series_hash)
    series[Date.parse("2013-07-27")].should == 10
    series[Date.parse("2013-07-28")].should == 0
    series[Date.parse("2013-08-01")].should == 7

    series = ZeroFill.by_date(series_array_of_hashes_string_values)
    series.first[:comida].should == "paella"
    series.last[:comida].should == "tamale"
    series[1][:comida].should == 0
  end
end

describe "Options" do
  it "should return calendar months for included dates" do
    month_series = ZeroFill.by_date(series_array_of_hashes, includes: :month)
    month_series.count.should == 62
    month_series.first[:date].to_s.should == "2013-07-01"
    month_series.last[:date].to_s.should == "2013-08-31"
  end

  it "should return calendar weeks for included dates" do
    week_series = ZeroFill.by_date(series_array_of_hashes, includes: :week)
    week_series.count.should == 14
    week_series.first[:date].to_s.should == "2013-07-21"
    week_series.last[:date].to_s.should == "2013-08-03"
  end


  it "should allow missing dates to have a custom default value" do
    series = ZeroFill.by_date(series_array_of_hashes_string_values, default_value: "order pizza")
    series[1][:comida].should == "order pizza"
  end

  it "should create dates starting with the start_at date" do
    start_date = Date.parse("2013-07-26")
    array_series = ZeroFill.by_date(series_array_of_hashes, start_at: start_date)
    array_series.count.should == 7
    array_series.first[:date].should == start_date

    hash_series = ZeroFill.by_date(series_hash, start_at: start_date)
    hash_series.count.should == 7
    hash_series.keys.first.should == start_date
  end

  it "should create dates through the end_at date" do
    end_date = Date.parse("2013-08-10")

    array_series = ZeroFill.by_date(series_array_of_hashes, end_at: end_date)
    array_series.count.should == 15
    array_series.last[:date].to_s.should == end_date.to_s

    hash_series = ZeroFill.by_date(series_hash, end_at: end_date)
    hash_series.count.should == 15
    hash_series.keys.last.to_s.should == end_date.to_s
  end

  it "should accept a start_at and end_at date with an empty series" do
    ZeroFill.by_date([], start_at: Date.parse("2013-07-01"), end_at: Date.parse("2013-07-30")).count.should == 30
    ZeroFill.by_date({}, start_at: Date.parse("2013-07-01"), end_at: Date.parse("2013-07-30")).count.should == 30
  end

  it "should be able to sort series dates descending" do
    ZeroFill.by_date(series_array_of_hashes, order: :descending).map{|hash| hash[:date].to_s }.should == [
      "2013-08-01", "2013-07-31", "2013-07-30", "2013-07-29", "2013-07-28", "2013-07-27"
    ]
    ZeroFill.by_date(series_hash, order: :descending).keys.map{|date| date.to_s }.should == [
      "2013-08-01", "2013-07-31", "2013-07-30", "2013-07-29", "2013-07-28", "2013-07-27"
    ]
  end
end
