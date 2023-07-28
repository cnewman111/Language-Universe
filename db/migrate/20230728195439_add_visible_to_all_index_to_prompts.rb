class AddVisibleToAllIndexToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_index :prompts, :visible_to_all
  end
end
