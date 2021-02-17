class RenameCheckedColumnToNotifications < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :checked, :read
  end
end
