require 'spec_helper'

describe Youtube::Api::V3::Entities::Channel do
  describe '#initialize' do
    it 'is initialized from a youtube channel hash' do
      channel = Youtube::Api::V3::Entities::Channel.new(youtube_channel_hash)

      expect(channel.id).to          eq(youtube_channel_hash['id'])
      expect(channel.title).to       eq(youtube_channel_hash['snippet']['title'])
      expect(channel.description).to eq(youtube_channel_hash['snippet']['description'])
      expect(channel.thumbnail).to   eq(youtube_channel_hash['snippet']['thumbnails']['high']['url'])
      expect(channel.playlist_id).to eq(youtube_channel_hash['contentDetails']['relatedPlaylists']['uploads'])
    end
  end
end