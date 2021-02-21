class TagRelationship < ApplicationRecord
  belongs_to :project
  belongs_to :tag
  # belongs_to :influencer
end
