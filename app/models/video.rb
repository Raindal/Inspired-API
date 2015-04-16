class Video < ActiveRecord::Base
  before_create :set_released_at

  scope :latest, -> { order('released_at DESC').first }

  def initialize(*args)
    return super(attributes_from_youtube_video(args.first)) if args.first.is_a?(Youtube::Api::V3::Entities::Video)
    super(*args)
  end

  private

  def set_released_at
    return self.released_at = Date.today if Video.count == 0
    self.released_at = Video.latest.released_at + 1.day
  end

  def attributes_from_youtube_video(video)
    attributes = { youtube_id: video.id }
    [:title, :description, :thumbnail, :duration, :definition, :view_count].each do |attr|
      attributes.merge!(attr => video.send(attr))
    end
    attributes
  end
end