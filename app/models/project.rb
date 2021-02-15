class Project < ApplicationRecord

   belongs_to :company
   attachment :image
  validates :price,:title, length: { in: 1..75 }
  validates :details, length: { in: 1..140 }
  has_many :influencer_projects
  has_many :favorites, dependent: :destroy
  has_many :favorited_influencers, through: :favorites, source: :influencer
  
  has_many :notifications, dependent: :destroy

  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships
  def save_tags(saveproject_tags)
    saveproject_tags.each do |new_name|
    project_tag = Tag.find_or_create_by(name: new_name)
    self.tags << project_tag
   end
  end

  def favorite?(influencer)
    favorites.where(influencer_id: influencer.id).exists?
  end
end
