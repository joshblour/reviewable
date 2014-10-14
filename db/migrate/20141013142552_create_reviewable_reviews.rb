class CreateReviewableReviews < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    
    create_table :reviewable_reviews do |t|
      t.references :reviewable_object, :polymorphic => true
      t.references :reviewer, :polymorphic => true
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.json :results
      t.datetime :submitted_at

      t.timestamps
    end
  end
end
