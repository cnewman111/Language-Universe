class RemoveTrainingLanguageFromPrompts < ActiveRecord::Migration[7.0]
  def change
    remove_column :prompts, :training_language
  end
end
