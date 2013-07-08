class AddShortedUrlToNews < ActiveRecord::Migration
  def change
    add_column :news, :shorted_url, :string
  end
end
