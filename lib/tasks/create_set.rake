namespace :inspired do
  task :create_set do
    Inspired::Engine.create_set unless Video.exists?(released_at: Date.today + 2.days)
  end
end