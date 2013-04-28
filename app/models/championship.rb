class Championship < ActiveRecord::Base
  attr_accessible :name

  has_many :matches


  def name=(name)
    write_attribute(:name, name.downcase)
  end

  def name
    read_attribute(:name).humanize
  end
end