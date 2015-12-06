FactoryGirl.define do
  sequence :answerbody do |n|
    "AnswerText#{n}"
  end

  factory :answer do
    body :answerbody
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
  end
end
