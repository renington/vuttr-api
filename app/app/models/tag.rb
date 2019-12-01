class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tools, through: :taggings
end
