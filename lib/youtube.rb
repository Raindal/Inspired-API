module Youtube
  autoload :Data, './lib/youtube/data'

  module Api
    module V3
      autoload :Base, './lib/youtube/api/v3/base'
      autoload :Http, './lib/youtube/api/v3/http'

      module Entities
        autoload :Channel,      './lib/youtube/api/v3/entities/channel'
        autoload :Video,        './lib/youtube/api/v3/entities/video'
        autoload :PlaylistItem, './lib/youtube/api/v3/entities/playlist_item'
      end
    end
  end
end