module Youtube
  module Api
    module V3
      module Entities
        class PlaylistItem < Base
          PART = [:snippet]

          attr_accessor :id, :title, :description, :thumbnail, :video_id

          def initialize(playlist_item)
            self.id = playlist_item['id']
            self.title = playlist_item['snippet']['title']
            self.description = playlist_item['snippet']['description']
            self.thumbnail = best_thumbnail(playlist_item)
            self.video_id = playlist_item['snippet']['resourceId']['videoId']
          end

          class << self
            def for_playlist(id, options = {})
              playlist_items = where(entity: :playlistItems, maxResults: 50, part: PART, playlistId: id)
              playlist_items.map!(&method(:new)) if options[:as_objects]
              playlist_items
            end
          end
        end
      end
    end
  end
end