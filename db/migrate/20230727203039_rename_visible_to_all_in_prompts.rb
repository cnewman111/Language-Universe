class RenameVisibleToAllInPrompts < ActiveRecord::Migration[7.0]
  def change
    rename_column :prompts, :visible_to_all?, :visible_to_all
  end
end
