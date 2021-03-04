class Tag < ApplicationRecord
  has_many :tag_relationships, dependent: :destroy
  has_many :projects, through: :tag_relationships
  # has_many :influencers,through: :tag_relationships
  validates :name, uniqueness: true
  # has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships
end
