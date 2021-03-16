class Influencer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |influencer|
      influencer.email = auth.info.email
      influencer.password = Devise.friendly_token[0, 20]
    end
  end
  validates :name, :phone_number, :email, presence: true
  attachment :image

  has_many :favorites, dependent: :destroy
  has_many :favorited_projects, through: :favorites, source: :project

  has_many :influencer_projects

  has_many :reviews, dependent: :destroy

  def avg_rate
    if reviews.empty?
      0.0
    else
      reviews.average(:rate).round(1).to_f
    end
  end

  def avg_rate_percentage
    if reviews.empty?
      0.0
    else
      reviews.average(:rate).round(1).to_f * 100 / 5
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest1@example.com') do |influencer|
      influencer.password = SecureRandom.urlsafe_base64
      influencer.nickname = 'ゲスト1'
      # influencer.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # has_many  :tag_relationships, dependent: :destroy
  # has_many  :tags, through: :tag_relationships
  # def save_tags(saveinfluencer_tags)
  #   saveinfluencer_tags.each do |new_name|
  #   influencer_tag = Tag.find_or_create_by(name: new_name)
  #   influencer_tag
  #   pp influencer_tag
  #   self.tags << influencer_tag
  # end
  # end

  def already_favorited?(project)
    favorites.exists?(project_id: project.id)
  end

  # def create_notification(current_influencer)
  #   temp = Notification.where(["visitercompany_id = ? and visitedinflencer_id = ? and action = ? ",current_influencer.id, id])
  #   if temp.blank?
  #     notification = current_influencer.active_notifications.new(
  #       visitedinflencer_id: id,
  #       action: ''
  #     )
  #     notification.save if notification.valid?
  #   end
  # end
end
