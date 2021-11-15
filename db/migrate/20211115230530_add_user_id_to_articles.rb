class AddUserIdToArticles < ActiveRecord::Migration[6.1]
  def change
    remove_column :articles, :users
    add_column :articles, :user_id, :int
  end
end
