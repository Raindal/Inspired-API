def low_view_count_videos
  videos = []
  (1..10).each { |view_count| videos << double(view_count: view_count) }
  videos
end

def high_view_count_videos
  videos = []
  (100..110).each { |view_count| videos << double(view_count: view_count) }
  videos
end

def youtube_video
  Youtube::Api::V3::Entities::Video.new(youtube_video_hash)
end