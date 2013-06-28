class AddHalfToMove < ActiveRecord::Migration
  def change
    add_column :moves, :half, :integer
  end
end
