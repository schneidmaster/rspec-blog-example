class AssociateArticlesWithUsers < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer, references: :users
  end
end
