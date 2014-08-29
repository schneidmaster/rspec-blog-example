class AssociateCommentsWithUsers < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer, references: :users
  end
end
