class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitorcompany_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visitedcompany_id', dependent: :destroy
  
end
