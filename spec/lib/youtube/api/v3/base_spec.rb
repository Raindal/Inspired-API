require 'spec_helper'

describe Youtube::Api::V3::Base do
  describe '.where' do
    let(:params) {{ entity: 'channels', part: ['snippet', 'contentDetails'], x: 'y' }}

    it 'calls Http.list with the appropriate arguments' do
      allow(Youtube::Api::V3::Http).to receive(:list)
      expect(Youtube::Api::V3::Http).to receive(:list).with('channels', { x: 'y', part: 'snippet,contentDetails' })

      Youtube::Api::V3::Base.where(params)
    end

    it 'returns Http.list call result' do
      allow(Youtube::Api::V3::Http).to receive(:list).and_return('Frank Underwood')
      expect(Youtube::Api::V3::Base.where(params)).to eq('Frank Underwood')
    end
  end

  describe '.find' do
    let(:params) {{ entity: 'channels', part: ['snippet', 'contentDetails'], x: 'y' }}

    it 'returns the first result from where' do
      allow(Youtube::Api::V3::Http).to receive(:list).and_return(['Jon Snow', 'Frank Underwood'])
      expect(Youtube::Api::V3::Base).to receive(:where).with(params).and_call_original
      expect(Youtube::Api::V3::Base.find(params)).to eq('Jon Snow')
    end
  end
end