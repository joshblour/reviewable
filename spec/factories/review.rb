# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review, :class => 'Reviewable::Review' do
    association :reviewable_object, factory: :product
    association :reviewer, factory: :user
    
    
    # t.references :reviewable_object, :polymorphic => true
    # t.references :reviewer, :polymorphic => true
    # t.uuid :uuid, default: 'uuid_generate_v4()'
    # t.json :results

    trait :submitted do
      submitted_at {Time.now}
    end
    
    trait :unsubmitted do
    end
    
  end
end
