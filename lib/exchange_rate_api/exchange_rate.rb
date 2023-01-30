module ExchangeRateApi
  class ExchangeRate
    attr_reader :base, :quote, :rate

    def initialize(base, quote, rate)
      @base = base
      @quote = quote
      @rate = rate
    end
  end
end