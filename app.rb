require_relative 'time_format'

class App

   def call(env)
    response = Rack::Request.new(env)
    return rack(400, "Invalid_format_name\n") if response.params['format'].nil?

    formatter = TimeFormat.new(response.params)
    formatter.check_format
    if formatter.valid?
      rack(200, formatter.time)
    else
      rack(400, "Unknown time format#{formatter.incorrect}\n")
    end
  end

  def rack(status, body)
    Rack::Response.new(body, status).finish
  end
end
