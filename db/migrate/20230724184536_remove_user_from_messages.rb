class RemoveUserFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :user_id
  end
end
