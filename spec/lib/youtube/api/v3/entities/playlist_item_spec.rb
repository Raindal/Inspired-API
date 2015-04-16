require 'spec_helper'

describe Youtube::Api::V3::Entities::PlaylistItem do
  describe '#initialize' do
    it 'is initialized from a youtube playlist item hash' do
      playlist_item = Youtube::Api::V3::Entities::PlaylistItem.new(youtube_playlist_item_hash)

      expect(playlist_item.id).to          eq(youtube_playlist_item_hash['id'])
      expect(playlist_item.title).to       eq(youtube_playlist_item_hash['snippet']['title'])
      expect(playlist_item.description).to eq(youtube_playlist_item_hash['snippet']['description'])
      expect(playlist_item.thumbnail).to   eq(youtube_playlist_item_hash['snippet']['thumbnails']['maxres']['url'])
      expect(playlist_item.video_id).to    eq(youtube_playlist_item_hash['snippet']['resourceId']['videoId'])
    end
  end
end