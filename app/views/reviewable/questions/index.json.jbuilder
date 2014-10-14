json.questions do
  json.array! @questions do |question|
    json.partial! 'reviewable/questions/question', question: question
  end
end