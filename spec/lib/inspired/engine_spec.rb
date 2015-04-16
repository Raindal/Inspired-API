require 'spec_helper'

describe Inspired::Engine do
  describe '.create_set' do
    it 'saves the videos after going through the filtering and refinering process' do
      allow(Inspired::Engine).to receive(:fetch_videos)
      allow(Inspired::VideoFilter).to receive(:filter).and_return([youtube_video] * 11)
      expect { Inspired::Engine.create_set }.to change { Video.count }.by(10)
    end
  end

  describe Inspired::Engine::Refinery do
    describe '#keep_most_viewed!' do
      it 'keeps any number of most viewed videos' do
        less_viewed_videos = low_view_count_videos
        most_viewed_videos = high_view_count_videos

        refinery = Inspired::Engine::Refinery.new((less_viewed_videos + most_viewed_videos).shuffle)
        refinery.keep_most_viewed!(most_viewed_videos.size)

        most_viewed_videos.each do |video|
          expect(refinery.videos).to include(video)
        end

        expect(refinery.videos.size).to eq(most_viewed_videos.size)
      end
    end
  end

  describe '#convert_to_active_record!' do
    it 'converts youtube videos to active record ones' do
      refinery = Inspired::Engine::Refinery.new([youtube_video])
      refinery.convert_to_active_record!

      expect(refinery.videos.first).to be_a(Video)
    end
  end
end