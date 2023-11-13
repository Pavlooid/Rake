require_relative 'time_format'

class App

   def call(env)
    response = Rack::Request.new(env)
    if response.path_info != '/time'
      return [404, headers, [""]]
    elsif response.params['format'].nil?
      return [400, headers, ["Invalid_format_name\n"]]
    end

    formatter = TimeFormat.new(response.params)
    formatter.check_format
    if formatter.valid?
      [200, headers, ["#{formatter.time}\n"]]
    else
      [400, headers, ["Unknown time format#{formatter.incorrect}\n"]]
    end
  end

  private

  def headers
    { 'content-type' => 'text/plain' }
  end

end
