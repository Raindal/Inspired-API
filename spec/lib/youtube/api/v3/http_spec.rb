require 'spec_helper'

describe Youtube::Api::V3::Http do
  describe '.list' do
    let(:response) { double(header: 'header', code: 200, message: 'message', body: '{"items":"y"}') }

    it 'returns the response items' do
      allow(Youtube::Api::V3::Http).to receive(:get).and_return(response)
      expect(Youtube::Api::V3::Http.list('whatever')).to eq('y')
    end
  end

  describe Youtube::Api::V3::Http::Response do
    describe '#initialize' do
      let(:response) { double(header: 'header', code: 200, message: 'message', body: '{"items":"y"}') }

      it 'gets initialized from a response' do
        http_response = Youtube::Api::V3::Http::Response.new(response)

        [:header, :code, :message].each do |attr|
          expect(http_response.send(attr)).to eq(response.send(attr))
        end
      end

      it 'parses the body as a json' do
        expect(Youtube::Api::V3::Http::Response.new(response).body).to eq(JSON.parse(response.body))
      end
    end

    describe '#items' do
      let(:response) { double(header: 'header', code: 200, message: 'message', body: '{"items":"y"}') }

      it 'returns the items hash of the body' do
        expect(Youtube::Api::V3::Http::Response.new(response).items).to eq('y')
      end
    end
  end
end