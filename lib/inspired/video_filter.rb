module Inspired
  class VideoFilter
    class Validator
      def initialize(video)
        @video = video
      end

      def discard?
        bad_quality? || too_long? || already_in_database?
      end

      private

      def bad_quality?
        @video.definition != 'hd'
      end

      def too_long?
        minutes = @video.duration.match(/\APT(\d+).*\z/)[1]
        minutes.to_i > 9
      end

      def already_in_database?
        Video.exists?(youtube_id: @video.id)
      end
    end

    class << self
      def filter(videos)
        filtered_videos = []
        videos.each do |video|
          next if Validator.new(video).discard?
          filtered_videos << video
        end
        filtered_videos
      end
    end
  end
end