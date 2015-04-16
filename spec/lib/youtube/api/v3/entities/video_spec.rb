require 'spec_helper'

describe Youtube::Api::V3::Entities::Video do
  describe '#initialize' do
    it 'is initialized from a youtube video hash' do
      video = Youtube::Api::V3::Entities::Video.new(youtube_video_hash)

      expect(video.id).to          eq(youtube_video_hash['id'])
      expect(video.title).to       eq(youtube_video_hash['snippet']['title'])
      expect(video.description).to eq(youtube_video_hash['snippet']['description'])
      expect(video.thumbnail).to   eq(youtube_video_hash['snippet']['thumbnails']['maxres']['url'])
      expect(video.duration).to    eq(youtube_video_hash['contentDetails']['duration'])
      expect(video.definition).to  eq(youtube_video_hash['contentDetails']['definition'])
      expect(video.view_count).to  eq(youtube_video_hash['statistics']['viewCount'].to_i)
    end
  end
end