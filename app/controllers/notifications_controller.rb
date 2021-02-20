class NotificationsController < ApplicationController

  def index
  #current_userの投稿に紐づいた通知一覧
    @notifications = current_influencer.passive_notifications
    # @notifications = current_company.passive_notifications
  #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(read: false).each do |notification|
        notification.update_attributes(read: true)
    end
  end

  def destroy_all
  #通知を全削除
    @notifications = current_company.passive_notifications.destroy_all
    @notifications = current_influencer.passive_notifications.destroy_all
    redirect_to notifications_path
  end



end
