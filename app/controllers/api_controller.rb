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
    current_time = Time.parse("Janurary 4, 2018 01:00:00 pm")
    current_time = current_time - 5.hours
    #current_time = Time.now
    payload = {
      "method" => "shifts.lookup",
      "params" => [
        techops,
        current_time - 30.minutes,
        current_time + 15.minutes
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
      render(text: "No Shfit Found", status: 404)
    end
  end

  def check_auth
    auth_check_payload = {"method" => "config.info"}
    render(text: ApiHelper.api_request(auth_check_payload))
  end


  def current_shifts
    results = ApiHelper.api_request ({"method" => "dept.list"})
    techops = results.invert["Arcade"]
    current_time = Time.now
    current_time = Time.parse("Janurary 5, 2018 01:00:00 pm")
    current_time = current_time - 5.hours
    payload = {
      "method"=> "shifts.lookup",
      "params" => {
        "department_id" => techops,
        "start_time" => current_time - 4.hours - 30.minutes,
        "end_time" => current_time + 30.minutes
      }
    }
    resp = ApiHelper.api_request(payload)

    render(json: resp)
  end
end


# 999,~XzVXrA
# 1999,~tEtj8g
# 2999,~y2p8hA
# 1999,~tEtj8g
# 3999,~z8N7zQ
# 4999,~X7zmlw
# 5999,~xTG9OQ
# 6999,~FEc+3g
# 7999,~RVBDUA
# 8999,~4DmEOQ
# 9990,~v+hIRg
# 9991,~NtC8gA
# 9992,~NR+F5g
# 9993,~oJuFgg
# 9994,~QmlnIw
# 9995,~tg9K5Q
# 9996,~otizrg
# 9997,~dw77+g
# 9998,~WdcGLw
# 9999,~JIK2sQ
# 10999,~YG/I2g
# 11999,~EKRx8g
# 12999,~NZJAWw
# 13999,~M0bNeg
# 14999,~c3QIKQ
# 15999,~94Yd6A
# 16999,~E+JBkQ
# 17999,~PhTrEg
# 18999,~7hexPw
# 19990,~SttSZQ
# 19991,~hvLwAA
# 19992,~qV/z/A
# 19993,~L/vCww
# 19994,~xyBMfA
# 19995,~0E4f7Q
# 19996,~YWXiBQ
# 19997,~BNkzQQ
# 19998,~C8ENfA
# 19999,~TeO52w
# 20999,~9qKFKA
# 21999,~PTxzxA
# 22999,~mcGqUA
# 23999,~GFf15w
# 24999,~42CsbQ
# 25999,~39XmIA
# 26999,~dTyvlA
# 27999,~fmlhVw
# 28999,~1zAHvw
# 29990,~Yi2Hyw
# 29991,~CccysA
# 29992,~gg8Obg
# 29993,~w01lQg
# 29994,~jME9SA
# 29995,~UdWgsQ
# 29996,~DCFPyQ
# 29997,~kMA0rQ
# 29998,~cLyuzg
# 29999,~NHI8zA
# 30999,~vN+XKw
# 31999,~HvKEUA
# 32999,~VIqCYw
# 33999,~6QKqMQ
# 34999,~6PN2vQ
# 35999,~cGAw2A
# 36999,~7aobdw
# 37999,~9vkl5g
# 38999,~tx9qTg
# 39990,~R14z4A
# 39991,~AQoJ7g
# 39992,~aOjt1w
# 39993,~kGWqKw
# 39994,~7v1LKQ
# 39995,~74qDuA
# 39996,~2bGzyw
# 39997,~5H8wWw
# 39998,~qtCqVA
# 39999,~LRPvJA
# 40999,~TBbQSg
# 41999,~nEAQQQ
# 42999,~k3qFeg
# 43999,~sSpTTA
# 44999,~AKBQ1A
# 45999,~xv2V9Q
# 46999,~KNZ8HQ
# 47999,~PrNYbA
# 48999,~Yn+jEA
# 49990,~9UHqPA
# 49991,~8aqcDQ
# 49992,~1S5irQ
# 49993,~ga4vlw
# 49994,~4w61tg
# 49995,~aCYHxA
# 49996,~uwpjrw
# 49997,~VF1MGQ
# 49998,~ERINHg
# 49999,~RyazVw
# 50999,~okUchA
# 51999,~6lf0EA
# 52999,~m6ejGw
# 53999,~Gpi0CA
# 54999,~HOt1+A
# 55999,~+vGF2A
# 56999,~1o4N4g
# 57999,~3p+Z6Q
# 58999,~Ou/jcg
# 59990,~TxHczw
# 59991,~JzXCNQ
# 59992,~MRAeVw
# 59993,~cLY9Aw
# 59994,~Zt0JTg
# 59995,~8hyMAQ
# 59996,~fPzLzA
# 59997,~6d6yCw
# 59998,~wl0H3w
# 59999,~nlYXsg
