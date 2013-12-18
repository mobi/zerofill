class ZeroFill::HashSeries < ZeroFill

private #######################################################################

  def initialize(series, options={})
    @new_series = {}
    setup(series, options)
  end

  def validate_data_structure
    first_key = @series.keys.first
    raise TypeError, "Hash keys must be a Date or DateTime" unless first_key.kind_of?(Date)
  end

  def set_new_series_date_value!(current_date)
    matching_date = @series[current_date]
    @new_series[current_date] = matching_date || @options[:default_value]
  end

  def sort_series!
    @series = Hash[@series.sort{|a,b| a[0] <=> b[0] }]
  end

  def reverse_series!
    @new_series = Hash[@new_series.to_a.reverse]
  end

  def first_date
    @first_date ||= @series.empty? ? nil : @series.keys.first
  end

  def last_date
    @last_date ||= @series.empty? ? nil : @series.keys.last
  end

end
