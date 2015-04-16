require 'spec_helper'

describe Video do
  describe '#initialize' do
    it 'can receive regular arguments' do
      expect { Video.new(title: 'Frank Underwood', description: 'Whatever') }.not_to raise_error
    end

    it 'can receive a youtube video' do
      y_video = youtube_video
      video = nil
      expect { video = Video.new(y_video) }.not_to raise_error
      expect(video.youtube_id).to eq(y_video.id)
    end
  end

  describe 'creating a video' do
    context 'when no video exists' do
      it 'sets the released_at attribute as today' do
        video = Video.new(youtube_video).tap(&:save)
        expect(video.released_at).to eq(Date.today)
      end
    end

    context 'when at least one video exists' do
      it 'sets the released_at attribute as the latest video released_at + one day' do
        video1 = Video.new(youtube_video).tap(&:save)
        video2 = Video.new(youtube_video).tap(&:save)
        video3 = Video.new(youtube_video).tap(&:save)
        expect(video3.released_at).to eq(video2.released_at + 1.day)
      end
    end
  end

  describe '.latest' do
    it 'returns the video with the latest released_at' do
      video1 = Video.new(youtube_video).tap(&:save)
      video2 = Video.new(youtube_video).tap(&:save)

      expect(Video.latest.id).to eq(video2.id)

      video1.update_attributes(released_at: 1.year.from_now)

      expect(Video.latest.id).to eq(video1.id)
    end
  end
end