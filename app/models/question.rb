class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments

  validates :title, :body, :user_id, presence: true
end
