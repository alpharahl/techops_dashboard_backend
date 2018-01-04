class ApiController < ApplicationController
  def index
    res = ApiHelper.api_request({"method"=>"dept.list"})
    render(text: res)
  end

  def mark_shift_worked
    results = ApiHelper.api_request ({"method" => "dept.list"})
    techops = results.invert["Tech Ops"]

    payload = {
      "method" => "barcode.lookup_attendee_from_barcode",
      "params" => [params[:barcode]]
    }
    user = ApiHelper.api_request(payload)
    current_time = Time.now
    current_time = current_time - 4.hours
    payload = {
      "method" => "shifts.lookup",
      "params" => [
        techops,
        current_time - 30.minutes,
        current_time + 2.hours
      ]
    }
    jobs = ApiHelper.api_request(payload)
    shift = nil;
    jobs.each do |job|
      job["shifts"].each do |s|
        if s["attendee"]["id"] == user["id"]
          shift = s
        end
      end
    end

    if shift
      payload = {
        "method" => "shifts.set_worked",
        "params" => {
          "shift_id" => shift["id"],
          "status" => "59709335",
          "rating" => "54944008",
          "comment" => "Marked Via Techops Dashboard"
        }
      }
      resp = ApiHelper.api_request(payload)
      render(json: {"name" => resp["name"]}.to_json, status: 200)
    else
      # render(text: "No Shfit Found", status: 404)
      render(text: jobs)
    end
  end

  def check_auth
    auth_check_payload = {"method" => "config.info"}
    render(text: ApiHelper.api_request(auth_check_payload))
  end


  def current_shifts
    results = ApiHelper.api_request ({"method" => "dept.list"})
    techops = results.invert["Tech Ops"]
    current_time = Time.now
    # current_time = Time.parse("Janurary 4, 2018 01:00:00 pm")
    # current_time = current_time - 4.hours
    payload = {
      "method"=> "shifts.lookup",
      "params" => {
        "department_id" => techops,
        "start_time" => current_time - 4.hours - 30.minutes,
        "end_time" => current_time + 30.minutes
      }
    }
    resp = ApiHelper.api_request(payload)
    resp.each do |r|
      r["end_time"] = Time.parse(r["end_time"]) - 5.hours
      r["start_time"] = Time.parse(r["start_time"]) - 5.hours
    end

    render(json: resp)
  end
end
