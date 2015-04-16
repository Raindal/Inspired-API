module Youtube
  module Api
    module V3
      module Entities
        class Channel < Base
          PART = [:snippet, :contentDetails]

          attr_accessor :id, :title, :description, :thumbnail, :playlist_id

          def initialize(channel)
            self.id = channel['id']
            self.title = channel['snippet']['title']
            self.description = channel['snippet']['description']
            self.thumbnail = best_thumbnail(channel)
            self.playlist_id = channel['contentDetails']['relatedPlaylists']['uploads']
          end

          class << self
            def find(id)
              new super(entity: :channels, part: PART, id: id)
            end
          end
        end
      end
    end
  end
end