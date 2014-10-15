module Reviewable
  class Review < ActiveRecord::Base
    belongs_to :reviewable_object, polymorphic: true
    belongs_to :reviewer, polymorphic: true
    
    validates :reviewer_id, uniqueness: {scope: [:reviewable_object_type, :reviewable_object_id, :reviewer_type]}
    
    scope :submitted, -> {where.not(submitted_at: nil)}
    scope :unsubmitted, -> {where(submitted_at: nil)}
    
    after_initialize :build_default_result
    
    def sanitized_results
      enabled_ids = Question.enabled.pluck(:id).map(&:to_s)
      results.slice(*enabled_ids)
    end
    
    def submitted?
      submitted_at.present?
    end
    
    private
    
    def build_default_result
      self.results ||= Question.enabled.pluck(:id).inject({}) {|h, k| h[k] = ''; h }
    end
  end
end
