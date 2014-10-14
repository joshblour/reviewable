module Reviewable
  class Question < ActiveRecord::Base
    TYPES = ['string', 'integer', 'select', 'text']
    
    validates :question_text, :question_type, :slug, presence: true
    validates :slug, uniqueness: true
    validates :question_type, inclusion: TYPES
    
    scope :enabled, -> {where(enabled: true)}
    
    
    # before_validation :build_slug_if_missing
    
    before_save :sanitize_answer_options_string
    
    
    def answer_options
      if answer_options_string
        answer_options_string.split('|').map(&:strip)
      else
        []
      end
    end
    
    private
   
   
    def sanitize_answer_options_string
      self.answer_options_string = answer_options.join('|')
    end
    # def build_slug_if_missing
    #   self.slug = question_text.parameterize if slug.blank? && question_text
    # end
    

  end
end
