class Tool < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_presence_of :title

  def self.tagged_with(name)
    Tool.all.joins(:tags).where("tags.name = ?", name)
  end

  def tag_list
    tags.map(&:name)
  end

  def add_tags(tag_names)
    return if tag_names.nil?
    
    tag_names.each do |tag|
      self.tags << Tag.where(name: tag.strip).first_or_create!
    end
  end

  def as_json options={}
    {
      id: self.id,
      title: self.title,
      link: self.link,
      description: self.description,
      tags: tag_list
    }
  end

end