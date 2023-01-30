module ExchangeRateApi
  def self.stub_latest(currency, status_code: 200, response_body: nil)

    if response_body.nil?
      fixture_path = Rails.root.join('spec/fixtures/exchange_rate_api/success_latest_usd.json')
      response_body = File.read(fixture_path)
    end

    headers = {
      content_type: 'application/json'
    }

    stub_request(:get, get_url("latest/#{currency}"))
      .to_return(body: response_body, status: status_code, headers: headers)
  end

  private

  def self.api_key
    Rails.application.credentials.exchange_rate_api_key
  end

  def self.get_url(resource, api_key: self.api_key)
    "#{ExchangeRateApi::Client::BASE_URL}#{api_key}/#{resource}"
  end
end