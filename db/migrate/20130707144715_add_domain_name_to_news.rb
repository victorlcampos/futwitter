class AddDomainNameToNews < ActiveRecord::Migration
  def change
    add_column :news, :domain_name, :string
  end
end
