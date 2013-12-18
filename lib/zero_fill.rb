require "date"
class ZeroFill

  # by_date is a factory
  def self.by_date(series, options={})
    return series if series.empty? && !date_options_present?(options)

    if series.is_a? Hash
      zf = ZeroFill::HashSeries.new(series, options)
    elsif series.is_a? Array
      zf = ZeroFill::ArraySeries.new(series, options)
    else
      raise TypeError, "Date series must be a hash or array"
    end
    zf.series_by_date
  end

  def series_by_date
    populate_new_series
    reverse_series! if @options[:order].to_sym == :descending
    @new_series
  end

private #######################################################################

  def initialize(series, options={})
    raise NotImplementedError, "Use the ZeroFill.by_date factory"
  end

  def setup(series, options)
    @series = series
    unless @series.empty?
      validate_data_structure
      sort_series!
    end
    validate_date_options(options)

    @options = {
      order: :ascending,
      start_at: first_date,
      end_at: last_date,
      default_value: 0
    }.merge(options)

    set_range_series if @options[:includes]
  end

  def between_input_series?(current_date)
    @series.empty? || (current_date >= first_date && current_date <= last_date)
  end

  def set_range_series
    include_full_months_for_date_range if @options[:includes].to_sym == :month
    include_full_weeks_for_date_range if @options[:includes].to_sym == :week
  end

  def include_full_months_for_date_range
    @options[:start_at] = Date.civil(first_date.year, first_date.month, 1)
    @options[:end_at] = Date.civil(last_date.year, last_date.month, -1)    # -1 gives us the last day of the month
  end

  def include_full_weeks_for_date_range
    # Wednesday 2013-04-19 is the 3rd day of the week
    # So, 2013-04-19 minus 3 (days) returns the previous Sunday
    day_of_week = first_date.wday
    @options[:start_at] = first_date - day_of_week

    # Thursday, 2013-04-20 is the 4th day of the week
    # There are 6 days in the week (zero indexed). So, 6 minus 4 = 2 days until Saturday. So add 2 to the date to get the next Saturday
    day_of_week = last_date.wday
    @options[:end_at] = last_date + (6 - day_of_week)
  end

  def populate_new_series
    (@options[:start_at].to_date..@options[:end_at].to_date).each do |current_date|
      set_new_series_date_value!(current_date)
    end
  end

  def date_options_present?(options)
    ZeroFill.date_options_present?(options)
  end

  def self.date_options_present?(options)
    !options[:start_at].nil? && !options[:end_at].nil?
  end

  def validate_date_options(options)
    raise ArgumentError, "Start At Date cannot be after End At Date" if date_options_present?(options) && (options[:start_at] > options[:end_at])
  end

end

require "hash_series"
require "array_series"
