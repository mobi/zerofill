require 'rubygems'
require 'bundler/setup'
require 'zero_fill'

def series_array_of_hashes
  @series_array_of_hashes ||= [
    { date: Date.parse("2013-07-27"), count: 10 },
    { date: Date.parse("2013-08-01"), count: 7 },
    { date: Date.parse("2013-07-30"), count: 3 }
  ]
end

def series_array_of_hashes_string_values
  @series_array_of_hashes ||= [
    { dia: Date.parse("2013-07-27"), comida: "paella" },
    { dia: Date.parse("2013-08-01"), comida: "tamale" },
    { dia: Date.parse("2013-07-30"), comida: "fajita" }
  ]
end

def series_hash
  @date_list_hash ||= {
    Date.parse("2013-07-27") => 10,
    Date.parse("2013-08-01") => 7,
    Date.parse("2013-07-30") => 3
  }
end
