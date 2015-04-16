module Inspired
  class Engine
    class Refinery
      attr_reader :videos

      def initialize(videos)
        @videos = videos
      end

      def keep_most_viewed!(amount)
        @videos = @videos.sort_by { |v| -v.view_count }.slice(0, amount)
      end

      def convert_to_active_record!
        @videos.map! { |v| Video.new(v) }
      end
    end

    class << self
      def create_set
        videos = VideoFilter.filter(fetch_videos)
        refinery = Refinery.new(videos)
        refinery.keep_most_viewed!(10)
        refinery.convert_to_active_record!
        refinery.videos.each(&:save)
      end

      private

      def fetch_videos
        videos = []
        Youtube::Data::INSPIRING_CHANNELS.each do |_, youtube_id|
          channel = Youtube::Api::V3::Entities::Channel.find(youtube_id)
          playlist_items = Youtube::Api::V3::Entities::PlaylistItem.for_playlist(channel.playlist_id, as_objects: true)
          videos += Youtube::Api::V3::Entities::Video.for_ids(playlist_items.map(&:video_id), as_objects: true)
        end
        videos
      end
    end
  end
end