require_relative './exchange_rate'
require_relative './fetch_error'
require_relative './response'

module ExchangeRateApi
  class Client
    BASE_URL = "https://v6.exchangerate-api.com/v6/"
    def initialize
      @api_key = Rails.application.credentials.exchange_rate_api_key
    end

    def get_latest(currency_symbol)
      url = "#{BASE_URL}#{api_key}/latest/#{currency_symbol}"
      response = Faraday.get(url)

      if response.status != 200
        return ExchangeRateApi::Response.new(
          error: ExchangeRateApi::FetchError.new(currency_symbol, response)
        )
      end

      parsed_body = JSON.parse(response.body)

      data = parsed_body['conversion_rates'].map do |currency, rate|
        ExchangeRateApi::ExchangeRate.new(
          currency_symbol,
          currency,
          rate
        )
      end

      ExchangeRateApi::Response.new(data: data)
    end

    private

    attr_accessor :api_key
  end
end