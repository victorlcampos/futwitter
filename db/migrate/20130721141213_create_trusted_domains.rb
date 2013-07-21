class CreateTrustedDomains < ActiveRecord::Migration
  def change
    create_table :trusted_domains do |t|
      t.string :name

      t.timestamps
    end
  end
end
