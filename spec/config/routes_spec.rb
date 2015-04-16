require 'spec_helper'

describe 'Inspired' do
  context 'when no error occured' do
    before do
      allow(Inspired::DailyPackage).to receive(:new).and_return(x: 'y')
    end

    it 'serves the daily package' do
      date = '20150320'
      expect(Inspired::DailyPackage).to receive(:new).with(date)

      get "/#{date}"

      expect(last_response).to be_ok
      expect(last_response.body).to eq('{"x":"y"}')
    end
  end

  context 'when something wrong happened' do
    it 'returns status 500' do
      date = 'abcdefgh'
      expect(Inspired::DailyPackage).to receive(:new).with(date).and_call_original

      get "/#{date}"

      expect(last_response.status).to eq(500)
      expect(last_response.body).to be_empty
    end
  end
end