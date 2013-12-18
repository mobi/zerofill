ZeroFill
=====

ZeroFill makes it easy to add any missing dates to a series of dates. Popular use cases include calendars and charts with no data for some dates.

Compatible with Ruby 1.9.3 and 2.0.0 (and has no dependencies!). Untested in 1.8.7 but should work.

Example
------

For instance, say you want to output some info for these days:

```
July 29:   10
July 31:   7
August 2:  3
```
Wait - what about July 30 and August 1, the days missing from that list? ZeroFill can help!

```
July 29:   10
July 30:   0
July 31:   7
August 1:  0
August 2:  3
```
Voila! You have a series of 5 dates with zeros added for the missing dates.

Usage
====

__Simply pass a series (array or hash) into__ `ZeroFill.by_date()`

1. Pass a __hash__ of pairs of Dates (or DateTimes) and content (a string, integer, or whatever!):
```ruby
myDates = {
  Date.parse("2013-07-29") => 10, #Monday
  Date.parse("2013-07-31") => 7,  #Wednesday
  Date.parse("2013-08-02") => 3   #Friday
}
ZeroFill.by_date(myDates)
```

2. Or, pass an __array of hashes__. Each hash includes a Date or DateTime object and the value. _Note: the name of the keys in the hash are irrelevant as long as they are consistent throughout the array. ZeroFill automatically detects which key represents a Date/DateTime object_
```ruby
myDates = [
  { date: Date.parse("2013-07-31"), content: "My Birthday" },
  { date: Date.parse("2013-07-14"), content: "Movie Night" }
]
ZeroFill.by_date(myDates)
```

Get fancy with options:
--------------------------

1. Return all dates for any __months__ represented in your date series:
```ruby
myDates = [
  { date: Date.parse("2013-07-31"), content: "My Birthday" },
  { date: Date.parse("2013-08-13"), content: "First day of class" }
]
ZeroFill.by_date(myDates, includes: :month)
=> All dates in July & August
```

1. Return all dates for any __weeks__ represented in your date series:
```ruby
myDates = [
  { date: Date.parse("2013-07-31"), content: "My Birthday" }
]
ZeroFill.by_date(myDates, includes: :week)
=> All dates in the week of Saturday, July 28 to Sunday, August 3
```

1. __Sort dates__ from latest to earliest (Default is ascending - earliest to latest)
```ruby
ZeroFill.by_date(myDates, order: :descending)
```

1. __Change the default value__ of Zero Filled dates (Default is 0)
```ruby
ZeroFill.by_date(myDates, default_value: "Nothing Found!")
=> All missing dates' values are populated with "Nothing Found"
```

1. __Specify the start date__ of returned dates. For instance, to return dates starting with July 10:
```ruby
ZeroFill.by_date(myDates, start_at: Date.parse("2013-07-10"))
=> Returns dates from July 10 until the latest date in your series.
```

1. __Specify the end date__ of returned dates. For instance, to return dates ending with August 7:
```ruby
ZeroFill.by_date(myDates, end_at: Date.parse("2013-08-07"))
=> Returns dates from earliest date in your series through August 7
```

TODOs
====

* by_hour option - allow ZeroFill of hours. Include full-day support (like month option for by_date)
* by_month option - ZeroFill by month including support for full-year
* Support passing date strings instead of date objects
* Date padding option: Allow padding of the results by X days (i.e. show 3 days after the end of the series)

Contributions
=====
Knock out TODOs, add support for more input types, more formatting options, etc.

1. Fork the repo
1. Create a branch with a thoughtful name
1. Hack away
1. Add tests
1. Make sure the tests pass by running `rake`
1. Document any new options in the README
1. Squash your commits into logical groups
1. Submit a pull request and we'll see what happens!

Credits
=====
Copyright (c) 2013, developed and maintained by [MOBI Wireless Management](http://www.mobiwm.com/), and is released under the open MIT License. See the LICENSE file in this repository for details.
