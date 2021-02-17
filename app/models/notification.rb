class Notification < ApplicationRecord
  
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :influencer_project, optional: true

  belongs_to :visitor, class_name: 'Influencer', foreign_key: 'visitorinfluencer_id', optional: true
  belongs_to :visited, class_name: 'Influencer', foreign_key: 'visitedinfluencer_id', optional: true
  
  belongs_to :visitor, class_name: 'Company', foreign_key: 'visitorcompany_id', optional: true
  belongs_to :visited, class_name: 'Company', foreign_key: 'visitedcompany_id', optional: true
  
end
