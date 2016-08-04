class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :state, default: false
      t.string :multiple_answers
      t.references :exam, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
