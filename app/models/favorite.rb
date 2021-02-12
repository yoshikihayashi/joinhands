class Favorite < ApplicationRecord

  belongs_to :influencer
  belongs_to :project
  validates_uniqueness_of :project_id, scope: :influencer_id
end
