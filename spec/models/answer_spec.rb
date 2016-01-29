require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id}
  it { should validate_presence_of :user_id}
  it { should belong_to(:question) }

  describe '#make_best' do
    let!(:question) { create(:question) }
    let!(:answer) { create(:answer, question: question) }

    it 'sets best flag to true' do
      answer.make_best
      expect(answer).to be_best
    end

    it 'sets other answers flag to false' do
      other_answers = create_list(:answer, 2, question: question, best: true)
      answer.make_best
      other_answers.each do |a|
        expect(a.reload).to_not be_best
      end
    end

  end
end
