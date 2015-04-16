require 'spec_helper'

describe Inspired::DailyPackage do
  describe '#initialize' do
    context 'when it is called with a valid date' do
      let(:requested_date) { Date.today.strftime('%Y%m%d') }

      context 'when a video exists' do
        before { @video_in_db = Video.create! }

        it 'is initialized with the existing video' do
          expect(Inspired::DailyPackage.new(requested_date).instance_eval { @video }).to eq(@video_in_db)
        end
      end

      context 'when no video exists' do
        it 'raises the appropriate exception' do
          expect { Inspired::DailyPackage.new(requested_date) }.to raise_error(Inspired::VideoNotFound)
        end
      end
    end

    context 'when it gets called with an invalid date' do
      it 'raises the appropriate exception' do
        [nil, '0123', ''].each do |invalid_date|
          expect { Inspired::DailyPackage.new(invalid_date) }.to raise_error(Inspired::VideoNotFound)
        end
      end
    end
  end

  describe '#to_json' do
    it 'returns a json hash of the relevant values' do
      video = Video.create!(title: 'Frank Underwood', youtube_id: '42', thumbnail: 'http://thumbnail')
      daily_package_as_json = Inspired::DailyPackage.new(Date.today.strftime('%Y%m%d')).to_json
      video_relevant_values_as_json = { image_url: video.thumbnail, video_id: video.youtube_id, title: video.title }.to_json

      expect(daily_package_as_json).to eq(video_relevant_values_as_json)
    end
  end
end