module ApiHelper
  def self.api_request(payload)
    JSON.parse(RestClient::Request.execute(
      method: :post,
      url: 'https://staging4.uber.magfest.org/uber/jsonrpc/',
      payload: payload.to_json,
      headers: {"X-Auth-Token": ENV["api_token"]}
    ))["result"]
  end
end
