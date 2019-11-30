class Tag < ApplicationRecord
  has_many :taggings
  has_many :tools, through: :taggings
end
