module Inspired
  class DailyPackage
    def initialize(date)
      released_at = Time.new(*year_month_day_from(date)).to_date
      @video = Video.find_by!(released_at: released_at)
    rescue => e
      raise Inspired::VideoNotFound
    end

    def to_json
      { image_url: @video.thumbnail, video_id: @video.youtube_id, title: @video.title }.to_json
    end

    private

    def year_month_day_from(date)
      year  = date[0..3].to_i
      month = date[4..5].to_i
      day   = date[6..7].to_i
      [year, month, day]
    end
  end
end