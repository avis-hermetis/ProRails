class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments

  validates :question_id, :user_id, :body,  presence: true

  default_scope { order(best: :desc, created_at: :asc) }

  def make_best
    Answer.transaction do
      self.question.answers.update_all(best: false)
      self.update!(best: true)
    end
  end

end
