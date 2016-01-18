class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :question_id, :user_id, :body,  presence: true

  default_scope { order(best: :desc, created_at: :asc) }

  def make_best # обернуть в транзакцию
    self.question.answers.update_all(best: false)
    self.update!(best: true)
  end

end
