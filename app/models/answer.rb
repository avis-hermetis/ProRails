class Answer < ActiveRecord::Base
  validates :title, :body, presence: true
end
