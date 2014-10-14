require 'rails_helper'


# Feature: question delete
#   As a user
#   I want to delete a question
#   So it doesnt appear in reviews
feature 'question delete' do


  # Scenario: Admin can delete a question
  #   Given I am signed in
  #   When I delete a question
  #   Then I should see a question deleted message
  scenario 'admin can delete questions' do
    question = create(:question)
    visit questions_path
    expect{
      click_link 'Destroy'  
    }.to change{Reviewable::Question.count}.by(-1)
    
    expect(current_path).to eq questions_path
  end
  

end




