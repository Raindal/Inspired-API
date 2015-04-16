class AddIndexToVideosOnReleasedAt < ActiveRecord::Migration
  def change
    add_index :videos, :released_at
  end
end
