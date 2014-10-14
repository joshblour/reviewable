require 'rails_helper'


# Feature: question edit
#   As a Admin
#   I want to edit a question
#   So it appears differently
feature 'question edit', :js do

  before(:all) do
    @question = create(:question)
  end

  after(:all) do
    @question.destroy
  end


  before(:each) do
    visit edit_question_path(@question)
  end

  let(:question) {@question}

  # Scenario: Admin changes question text
  #   Given a question exists
  #   When I change the question text
  #   Then I see the new text
  scenario 'admin changes question text' do
    visit edit_question_path(question)

    fill_in 'question_question_text', :with => 'new question'
    click_button 'Update'
    expect(current_path).to eq questions_path
    question.reload
    expect(question.question_text).to eq 'new question'
  end


  # Scenario: Admin changes question type
  #   Given a question exists
  #   When I change the question type to integer
  #   Then the details change
  scenario 'admin changes question text' do
    visit edit_question_path(question)

    select 'integer', from: 'question_question_type'
    fill_in 'question_answer_min', with: '1'
    fill_in 'question_answer_max', with: '5'
    click_button 'Update'
    expect(current_path).to eq questions_path
    question.reload
    expect(question.question_type).to eq 'integer'
    expect(question.answer_min).to eq 1
    expect(question.answer_max).to eq 5
  end


  # Scenario: Admin makes a select question
  #   Given a question exists
  #   When I change question type to select
  #   And I provide pipe separated options
  #   Then the details change
  scenario 'admin changes question text' do
    visit edit_question_path(question)

    select 'select', from: 'question_question_type'
    fill_in 'question_answer_options_string', with: 'great|ok|bad'
    click_button 'Update'
    expect(current_path).to eq questions_path
    question.reload
    expect(question.answer_options_string).to eq 'great|ok|bad'
  end


  # Scenario: Admin enables question
  #   Given a question exists
  #   When I enable the question
  #   Then it's included in enabled questions
  scenario 'admin enables question' do
    question.update(enabled: false)
    visit edit_question_path(question)

    check 'question_enabled'
    click_button 'Update'
    expect(current_path).to eq questions_path
    expect(Reviewable::Question.enabled).to include(question)
  end


  # # Scenario: Admin enables question
  # #   Given a question exists
  # #   When I enable the question
  # #   Then it's included in enabled questions
  # scenario 'admin disables question' do
  #   question.update(enabled: true)
  #
  #   visit edit_question_path(question)
  #
  #   uncheck 'question_enabled'
  #   click_button 'Update'
  #   expect(current_path).to eq questions_path
  #   expect(Reviewable::Question.enabled).not_to include(question)
  # end

end
