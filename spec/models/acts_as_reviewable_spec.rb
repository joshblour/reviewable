require 'rails_helper'

module Reviewable
  RSpec.describe Product, :type => :model do
    
    it { should have_many(:reviews) }
    it { should accept_nested_attributes_for(:reviews) }
    
    it 'find review by reviewer' do
      review = create(:review)
      product = review.reviewable_object
      user = review.reviewer
      
      expect(product.review_from(user)).to eq review
    end
  end
end
