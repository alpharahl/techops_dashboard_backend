class ApiController < ApplicationController
  def index

    results = ApiHelper.api_request ({"method" => "dept.list"})
    techops = results.invert["Arcade"]

    payload = {
      "method" => "shifts.lookup",
      "params" => [techops,
        Time.parse("Janurary 6, 2018 05:00:00 am"),
        Time.parse("Janurary 7, 2018 05:00:00 am")
      ]
    }
    @resp = ApiHelper.api_request(payload)
  end

  def mark_shift_worked
    results = ApiHelper.api_request ({"method" => "dept.list"})
    techops = results.invert["Arcade"]

    payload = {
      "method" => "barcode.lookup_attendee_from_barcode",
      "params" => [params[:barcode]]
    }
    user = ApiHelper.api_request(payload)
    current_time = Time.parse("Janurary 7, 2018 04:00:00 pm")
    #current_time = Time.now
    payload = {
      "method" => "shifts.lookup",
      "params" => [
        techops,
        current_time - 15.minutes,
        current_time + 30.minutes
      ]
    }

    puts payload

    @resp = ApiHelper.api_request(payload)
  end

  def check_auth
    auth_check_payload = {"method" => "config.info"}
    ApiHelper.api_request(auth_check_payload)
  end
end
