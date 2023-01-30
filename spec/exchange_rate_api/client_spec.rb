require 'rails_helper'
require 'exchange_rate_api/client'

RSpec.describe ExchangeRateApi::Client do
  subject(:client) { described_class.new }

  describe '#get_latest' do
    let(:currency_symbol) { 'USD' }

    subject(:get_latest) { client.get_latest(currency_symbol) }
    subject(:success?) { get_latest.success? }
    subject(:failure?) { get_latest.failure? }
    subject(:data) { get_latest.data }

    context 'when request succeeds' do
      let!(:stub) { ExchangeRateApi.stub_latest(currency_symbol) }

      after(:each) { expect(stub).to have_been_requested }

      it { expect(get_latest).to be_a(ExchangeRateApi::Response) }
      it { expect(success?).to be_truthy }
      it { expect(failure?).to be_falsey }
      it { expect(data).to be_a(Array) }
      it { expect(data).not_to be_empty }
    end

    context 'when request fails' do
      let!(:stub) { ExchangeRateApi.stub_latest(currency_symbol, status_code: 500) }

      after(:each) { expect(stub).to have_been_requested }

      it { expect(get_latest).to be_a(ExchangeRateApi::Response) }
      it { expect(success?).to be_falsey }
      it { expect(failure?).to be_truthy }
      it { expect(data).to be_nil }
    end
  end
end
