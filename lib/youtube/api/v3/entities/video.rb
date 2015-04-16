module Youtube
  module Api
    module V3
      module Entities
        class Video < Base
          PART = [:snippet, :contentDetails, :statistics]

          attr_accessor :id, :title, :description, :thumbnail, :duration, :definition, :view_count

          def initialize(video)
            self.id = video['id']
            self.title = video['snippet']['title']
            self.description = video['snippet']['description']
            self.thumbnail = best_thumbnail(video)
            self.duration = video['contentDetails']['duration']
            self.definition = video['contentDetails']['definition']
            self.view_count = video['statistics']['viewCount'].to_i
          end

          class << self
            def for_ids(ids, options = {})
              videos = where(entity: :videos, maxResults: 50, part: PART, id: ids.join(','))
              videos.map!(&method(:new)) if options[:as_objects]
              videos
            end
          end
        end
      end
    end
  end
end