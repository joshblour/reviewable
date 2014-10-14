require 'rails_helper'

module Reviewable
  RSpec.describe Review, :type => :model do
    
    before(:all) do
      questions = create_list(:question, 5, :enabled)
      questions += create_list(:question, 5, :disabled)
    end
    
    after(:all) do
      Question.destroy_all
    end
    
    it "creates a review with all default enabled questions" do
      review = Review.create
      expect(review.results.keys).to match_array Question.enabled.pluck(:id).map(&:to_s)
      expect(review.results.values.uniq).to eq [""]
    end
    
    it "generates a uuid on create" do
      review = Review.create
      review.reload
      expect(review.uuid).not_to be_blank
    end
    
    
    it "returns submitted reviews only" do
      submitted_reviews = create_list(:review, 5, :submitted)
      unsubmitted_reviews = create_list(:review, 5, :unsubmitted)
      
      expect(Review.submitted).to match_array submitted_reviews
    end
    
    it "returns unsubmitted reviews only" do
      submitted_reviews = create_list(:review, 5, :submitted)
      unsubmitted_reviews = create_list(:review, 5, :unsubmitted)
      
      expect(Review.unsubmitted).to match_array unsubmitted_reviews
    end
    
    it "doesn't let reviewer review same reviewable object twice" do
      review = create(:review)
      expect {
        create(:review, reviewable_object: review.reviewable_object, reviewer: review.reviewer)
      }.to raise_error ActiveRecord::RecordInvalid
    end
    
    it "returns results from enabled questions only" do
      results = Question.all.inject({}) {|h,q| h[q.id] = 'answer blah'; h}
      review = create(:review, results: results)
      expect(review.sanitized_results.keys).to match_array Question.enabled.pluck(:id).map(&:to_s)
    end
    
    pending 'validates integer answer within range'
    
    pending 'returns rating average (int questions only) for a collection of records'
    
    
  end
end
