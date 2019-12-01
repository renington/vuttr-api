class Tool < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tool.all.joins(:tags).where("tags.name = ?", name)
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name)
  end

  def tag_list=(names)
    self.tags = names.map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def add_tags(tags)
    tags.each { |tag| self.tags.build name: tag }
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