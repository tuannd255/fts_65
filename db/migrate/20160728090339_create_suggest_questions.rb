class CreateSuggestQuestions < ActiveRecord::Migration
  def change
    create_table :suggest_questions do |t|
      t.string :question
      t.integer :question_type
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
