class InfluencerProject < ApplicationRecord

  belongs_to :influencer
  belongs_to :project

  has_many :notifications, dependent: :destroy
  
  

  enum status: { request: 0, rejection: 1, approval: 2, completion: 3 }
              # 0 = 申請中, 　1 = 却下, 　　2 = 承認, 　　3 = 完了
end
