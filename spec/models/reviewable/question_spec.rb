require 'rails_helper'

module Reviewable
  RSpec.describe Question, :type => :model do
    
    it { should validate_presence_of(:question_text) }
    it { should validate_presence_of(:question_type) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_inclusion_of(:question_type).in_array(Question::TYPES) }
        
    it "returns only enabled questions" do
      enabled_questions = create_list(:question, 5, :enabled)
      disabled_questions = create_list(:question, 5, :disabled)
      
      expect(Question.enabled).to match_array enabled_questions
    end
    
    pending "auto generates slug if not provided"
    
    it 'returns answer_options_string as a stripped array' do
      question = create(:question, question_type: 'select', answer_options_string: 'great  |   ok     | bad')
      expect(question.answer_options).to match_array ['great', 'ok', 'bad']
    end
    
  end
end