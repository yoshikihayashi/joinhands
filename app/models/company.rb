class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  validates :phone_number, :email, presence: true
  validates :company_name, length: { in: 2..50 }
  has_many :company_reviews, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorcompany_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedcompany_id', dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest1@example.com') do |company|
      company.password = SecureRandom.urlsafe_base64
      company.company_name = 'ゲスト1'
      company.phone_number = '00011112222'
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
