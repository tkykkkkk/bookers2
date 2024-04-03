class RenameColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :Relationships, :user_id, :follower_id
    rename_column :Relationships, :book_id, :followed_id
  end
end
