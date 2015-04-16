class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string  :youtube_id, index: true
      t.string  :title
      t.text    :description
      t.string  :thumbnail
      t.string  :duration
      t.string  :definition
      t.integer :view_count
      t.date    :released_at
      t.timestamps
    end
  end
end
