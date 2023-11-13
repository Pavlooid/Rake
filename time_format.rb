class TimeFormat

  TIME_FORMATS = { 
    "year"   => "%Y",
    "month"  => "%m",
    "day"    => "%d",
    "hour"   => "%H",
    "minute" => "%M",
    "second" => "%S"
  }

  attr_reader :incorrect

  def initialize(params)
    @params = params['format'].split(',')
  end

  def check_format
    @correct, @incorrect = @params.partition { |format| TIME_FORMATS[format] }
  end

  def valid?
    @incorrect.empty?
  end

  def time
    formats = @correct.map { |format| TIME_FORMATS[format]}
    Time.now.strftime(formats.join('-'))
  end
end
