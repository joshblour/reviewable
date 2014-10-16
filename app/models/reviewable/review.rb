module Reviewable
  class Review < ActiveRecord::Base
    belongs_to :reviewable_object, polymorphic: true
    belongs_to :reviewer, polymorphic: true
    
    validates :reviewer_id, uniqueness: {scope: [:reviewable_object_type, :reviewable_object_id, :reviewer_type]}
    
    scope :submitted, -> {where.not(submitted_at: nil)}
    scope :unsubmitted, -> {where(submitted_at: nil)}
        
    accepts_store_attributes_for :results, allow_destroy: true
    
    def sanitized_results
      enabled_ids = Question.enabled.pluck(:id).map(&:to_s)
      results.slice(*enabled_ids)
    end
    
    def submitted?
      submitted_at.present?
    end
    
    def answer_to_question id
      result = results.detect {|r| r['question_id'] == id}
      result['answer'] if result
    end

  end
end
