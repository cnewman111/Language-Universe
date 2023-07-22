class CreatePrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :prompts do |t|
      t.string :ai_name, null:false
      t.text :setting
      t.string :training_language
      t.string :native_language
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.boolean :visible_to_all, default: false

      t.timestamps
    end
  end
end
