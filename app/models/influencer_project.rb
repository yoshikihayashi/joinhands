class InfluencerProject < ApplicationRecord
  belongs_to :influencer
  belongs_to :project

  enum status: { request: 0, rejection: 1, approval: 2, completion: 3, perfect: 4 }
  # 0 = 申請中, 　1 = 却下, 　　2 = 承認, 　　3 = 完了      4 = 終了

  validates_uniqueness_of :influencer_id, scope: :project_id
end
