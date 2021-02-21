class InfluencerProject < ApplicationRecord

  belongs_to :influencer
  belongs_to :project

  # has_many :notifications, dependent: :destroy

  # def create_notification_by(current_company)
  #   notification = current_company.active_notifications.new(
  #     influencer_project_id: id,
  #     visitedinflencer_id: influencer_id,
  #     action: ""
  #   )
  #   notification.save if notification.valid?
  # end

                                                                # レビュー:4
  enum status: { request: 0, rejection: 1, approval: 2, completion: 3 }
              # 0 = 申請中, 　1 = 却下, 　　2 = 承認, 　　3 = 完了





end
