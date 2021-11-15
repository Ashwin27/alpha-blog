class AddUsersToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :users, :int
  end
end
