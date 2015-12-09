FactoryGirl.define do
  sequence :qtitle  do |n|
    "MyString#{n}"
  end
  sequence :qbody  do |n|
    "MyText#{n}"
  end

  factory :question do
    title :qtitle
    body :qbody
    user
  end

  factory :question_with_answers, class: 'Question' do
    transient do
      answers_count 5
    end

    after(:create) do |question, evaluator|
    create_list(answer, evaluator.answers_count, question: question)
    end
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end
