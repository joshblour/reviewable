class CreateReviewableQuestions < ActiveRecord::Migration
  def change
    create_table :reviewable_questions do |t|
      t.string :question_text
      t.string :question_type
      t.string :slug
      t.string :answer_options_string
      t.integer :answer_min
      t.integer :answer_max
      t.boolean :enabled

      t.timestamps
    end
  end
end
