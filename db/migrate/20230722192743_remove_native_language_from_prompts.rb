class RemoveNativeLanguageFromPrompts < ActiveRecord::Migration[7.0]
  def change
    remove_column :prompts, :native_language
  end
end
