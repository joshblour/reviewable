require 'rails_helper'


# Feature: questions index page
#   As a admin
#   I want to see a list of questions
#   So I can see all questions
feature 'question index page' do


  # Scenario: question listed on index page
  #   Given I am signed in
  #   When I visit the question index page
  #   Then I see all question texts
  scenario 'admin sees all questions' do
    questions = create_list(:question, 5)
    visit questions_path
    questions.each do |q|
      expect(page).to have_content q.question_text
    end
  end

end
