class ZeroFill::ArraySeries < ZeroFill

private #######################################################################

  def initialize(series, options={})
    @new_series = []
    setup(series, options)
  end

  def validate_data_structure
    arr = @series.sample
    raise TypeError, "Array elements must be hashes" unless arr.is_a? Hash
    raise TypeError, "Array elements must be hashes with two key/value pairs (a date and metadata)" unless arr.length == 2
    @date_key, @info_key = if arr.values.first.kind_of?(Date)
      [arr.keys.first, arr.keys.last]
    elsif arr.values.kind_of?(Date)
      [arr.keys.last, arr.keys.first]
    else
      raise TypeError, "No date object found for #{arr.inspect}"
    end
  end

  def set_new_series_date_value!(current_date)
    matching_date = between_input_series?(current_date) ? date_values.detect{|c| c[@date_key] == current_date} : nil
    @new_series << {
      @date_key => current_date,
      @info_key => (matching_date ? matching_date[@info_key] : @options[:default_value])
    }
  end

  def sort_series!
    @series.sort!{|a,b| a[@date_key] <=> b[@date_key] }
  end

  def reverse_series!
    @new_series.reverse!
  end

  def first_date
    @first_date ||= @series.empty? ? nil : @series.first[@date_key]
  end

  def last_date
    @last_date ||= @series.empty? ? nil : @series.last[@date_key]
  end

  def date_values
    @date_values ||= @series.each do |day|
      day[@date_key] = day[@date_key].to_date
    end
  end

end
