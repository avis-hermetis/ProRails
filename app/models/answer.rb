class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :question, :user, :body,  presence: true
end
