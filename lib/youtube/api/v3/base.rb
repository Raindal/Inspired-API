module Youtube
  module Api
    module V3
      class Base
        KEY = ENV['YOUTUBE_DATA_API_KEY']

        protected

        def best_thumbnail(item)
          image = nil
          %w(maxres standard high medium default).each do |definition|
            image = item['snippet']['thumbnails'][definition]
            break if image
          end
          image['url']
        end

        class << self
          def find(params)
            where(params).first
          end

          def where(params)
            entity = params.delete(:entity)
            params = prepare(params)
            Http.list(entity, params)
          end

          private

          def prepare(params)
            part = params.delete(:part)
            params.merge(part: part.join(','))
          end
        end
      end
    end
  end
end