class AddInternetUrlToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :internet_url, :string
  end
end
