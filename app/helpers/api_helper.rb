module ApiHelper
  def self.api_request(payload)
    JSON.parse(RestClient::Request.execute(
      method: :post,
      url: 'https://super2018.uber.magfest.org/uber/jsonrpc/',
      payload: payload.to_json,
      headers: {"X-Auth-Token": ENV["API_TOKEN"]}
    ))["result"]
  end
end
