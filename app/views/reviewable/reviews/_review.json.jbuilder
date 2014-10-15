json.id review.id
json.results do
  json.array! @questions do |q|
    json.question do
      json.partial! 'questions/question', question: q
    end
    json.answer review.answer_to_question q.id
  end
end