class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  validates :company_name, :phone_number, :email, presence: true
  has_many :company_reviews, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorcompany_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedcompany_id', dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest1@example.com') do |company|
      company.password = SecureRandom.urlsafe_base64
    end
  end

  def create_notification(current_company)
    temp = Notification.where(["visiterinfluencer_id = ? and visitedcompany_id = ? and action = ? ", current_company.id, id])
    if temp.blank?
      notification = current_company.active_notifications.new(
        visitedcompany_id: id,
        action: ''
      )
      notification.save if notification.valid?
    end
  end

  def avg_rate
    if company_reviews.empty?
      0.0
    else
      company_reviews.average(:rate).round(1).to_f
    end
  end

  def avg_rate_percentage
    if company_reviews.empty?
      0.0
    else
      company_reviews.average(:rate).round(1).to_f * 100 / 5
    end
  end
end
