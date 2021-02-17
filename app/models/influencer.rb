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

  def already_favorited?(project)
    self.favorites.exists?(project_id: project.id)
  end
end
