module Youtube
  module Api
    module V3
      class Http
        BASE_URI = 'https://www.googleapis.com/youtube/v3'

        class Response
          attr_accessor :header, :code, :message, :body

          def initialize(response)
            self.header  = response.header
            self.code    = response.code
            self.message = response.message
            self.body    = JSON.parse(response.body)
          end

          def items
            body['items']
          end
        end

        class << self
          def list(entity, params = {})
            uri       = URI("#{BASE_URI}/#{entity}")
            uri.query = URI.encode_www_form({ key: Base::KEY }.merge(params))
            Response.new(get(uri)).items
          end

          private

          def get(uri)
            Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
              request  = Net::HTTP::Get.new(uri.to_s)
              response = http.request(request)
            end
          end
        end
      end
    end
  end
end