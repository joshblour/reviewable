# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question, :class => 'Reviewable::Question' do
    sequence(:question_text) {|n| "question_#{n}"}
    question_type { Reviewable::Question::TYPES.sample }
    sequence(:slug) {|n| "slug_#{n}"}
    # t.string :question_text
    # t.string :question_type
    # t.string :slug
    # t.string :answer_options_string, array: true
    # t.integer :answer_min
    # t.integer :answer_max
    # t.boolean :enabled
    # enabled true
    
    trait :enabled do
      enabled true
    end
    
    trait :disabled do
      enabled false
    end
  end
end
