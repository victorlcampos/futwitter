class Move < ActiveRecord::Base
  default_scope order("id DESC")

  belongs_to :match
end
