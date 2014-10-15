json.id review.id
json.uuid review.uuid

json.results do
  json.array! @questions do |q|
    json.question do
      json.partial! 'reviewable/questions/question', question: q
    end
    json.answer review.answer_to_question q.id
  end
end

json.submitted_at review.submitted_at

json.updated_at review.updated_at
json.created_at review.created_at  
