module ExchangeRateApi
  class FetchError < StandardError
    def initialize(currency_symbol, response)
      super("Failed to fetch exchange rate for #{currency_symbol}, response=(status=#{response.status})")
    end
  end
end