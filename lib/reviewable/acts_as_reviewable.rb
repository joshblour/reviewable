module Reviewable
  module ActsAsReviewable
    
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def acts_as_reviewable
        include Reviewable::ActsAsReviewable::LocalInstanceMethods
  
        has_many :reviews, as: :reviewable_object, class_name: 'Reviewable::Review'

        accepts_nested_attributes_for :reviews, allow_destroy: true
      end
    end
    
    module LocalInstanceMethods
      
      def review_from reviewer
        reviews.where(reviewer: reviewer).first
      end
      
    end
  end
end

ActiveRecord::Base.send :include, Reviewable::ActsAsReviewable
