module ExchangeRateApi
  class Response
    attr_accessor :data, :error

    def initialize(data: nil, error: nil)
      if error.present? && !error.is_a?(StandardError)
        raise ArgumentError.new("error must inherit from StandardError")
      end

      @data = data
      @error = error
    end

    def success?
      error.nil?
    end

    def failure?
      !success?
    end
  end
end