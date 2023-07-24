class AddCreatingEntityToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :creating_entity, :string
  end
end
