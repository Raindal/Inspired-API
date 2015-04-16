get '/:date' do
  content_type :json
  Inspired::DailyPackage.new(params[:date]).to_json rescue status 500
end