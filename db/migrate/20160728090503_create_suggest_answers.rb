class CreateSuggestAnswers < ActiveRecord::Migration
  def change
    create_table :suggest_answers do |t|
      t.string :answer
      t.boolean :is_correct
      t.references :suggest_question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
