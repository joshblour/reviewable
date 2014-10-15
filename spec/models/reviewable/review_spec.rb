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
    
    let(:valid_attributes) do
      Question.enabled.pluck(:id).each_with_index.inject({}) do |hash, (id, i)|
        hash[i] = {question_id: id, answer: rand(5).to_s}
        hash
      end
    end
    
    it "creates a review with all default enabled questions" do
      review = Review.create
      
      expect(review.results.map {|r| r['question_id']}).to match_array Question.enabled.pluck(:id)
      expect(review.results.map {|r| r['answer']}.uniq).to match_array [""]
    end
    
    it "sets results as nested_attributes" do
      review = Review.create(results_attributes: valid_attributes)
      expect(review.results).to match_array valid_attributes.values.map(&:stringify_keys)
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
    
    it 'returns true if review is submitted' do
      review = create(:review, :submitted)
      expect(review.submitted?).to be true
    end
    
    it 'returns false if review is unsubmitted' do
      review = create(:review, :unsubmitted)
      expect(review.submitted?).to be false
    end
    
    pending 'validates integer answer within range'
    
    pending 'returns rating average (int questions only) for a collection of records'
    
    
  end
end
