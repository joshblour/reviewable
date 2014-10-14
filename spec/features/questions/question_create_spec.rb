require 'rails_helper'


# Feature: Question create
#   As an admin
#   I want to create a new question
#   So it appears on reviews
feature 'Question create' do



  # Scenario: Admin can create questions
  #   Given I am signed in
  #   When I fill in a question form
  #   And I click Create
  #   Then a new question gets created
  scenario "admin create questions" do
    visit new_question_path
    fill_in 'question_question_text', with: 'who are you?'
    select 'string', from: 'question_question_type'
    fill_in 'question_slug', with: 'who-are-you'
    check 'question_enabled'
    expect {
      click_button 'Create'
    }.to change{Reviewable::Question.count}.by(1)
    expect(current_path).to eq questions_path
  end
  
  # Scenario: Admin cannot create invalid questions
  #   Given I am signed in
  #   When I dont fill in a question form
  #   And I click Create
  #   Then a new question is not created
  #   And I see validation errors
  scenario "admin create questions" do
    visit new_question_path
    expect {
      click_button 'Create'
    }.not_to change{Reviewable::Question.count}
    expect(page).to have_content "can't be blank"    
  end

end
