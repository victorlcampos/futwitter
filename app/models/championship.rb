class Championship < ActiveRecord::Base
  scope :order_by_matches_count, order('matches_count Desc, name Asc')

  attr_accessible :name
  has_many :matches


  def name=(name)
    write_attribute(:name, name.downcase)
  end

  def name
    read_attribute(:name).humanize
  end
end