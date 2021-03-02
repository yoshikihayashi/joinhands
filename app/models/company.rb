class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy

  has_many :company_reviews, dependent: :destroy


  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorcompany_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedcompany_id', dependent: :destroy


  def create_notification(current_company)
    temp = Notification.where(["visiterinfluencer_id = ? and visitedcompany_id = ? and action = ? ",current_company.id, id])
    if temp.blank?
      notification = current_company.active_notifications.new(
        visitedcompany_id: id,
        action: ''
      )
      notification.save if notification.valid?
    end
  end

  def avg_rate
    unless self.company_reviews.empty?
      company_reviews.average(:rate).round(1).to_f
    else
      0.0
    end
  end

  def avg_rate_percentage
    unless self.company_reviews.empty?
     company_reviews.average(:rate).round(1).to_f*100/5
    else
     0.0
    end
  end

end
