class Influencer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image

  has_many :favorites, dependent: :destroy
  has_many :favorited_projects, through: :favorites, source: :project

  has_many :influencer_projects

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorinfluencer_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedinflencer_id', dependent: :destroy

  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships
  def save_tags(saveinfluencer_tags)
    saveinfluencer_tags.each do |new_name|
    influencer_tag = Tag.find_or_update_by(name: new_name)
    self.tags << influencer_tag
  end
  end

  def already_favorited?(project)
    self.favorites.exists?(project_id: project.id)
  end

  def create_notification(current_influencer)
    temp = Notification.where(["visitercompany_id = ? and visitedinflencer_id = ? and action = ? ",current_influencer.id, id])
    if temp.blank?
      notification = current_influencer.active_notifications.new(
        visitedinflencer_id: id,
        action: ''
      )
      notification.save if notification.valid?
    end
  end
end
