require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question) }

  describe 'POST #create' do
    let(:answer) { build(:answer) }

    before  do
      sign_in user
    end


    context 'with valid attributes do' do

      it 'saves the new answer to the database' do
        expect{ post :create, question_id: question, answer: attributes_for(:answer), format: :js }.
            to change(question.answers, :count).by(1)
      end

      it 'connects the answer with the current user' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer).user.id).to eq controller.current_user.id
      end

      it 'assigns the requested question to @question' do
        post :create, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:question)).to eq question
      end

    end

    context 'with invalid attributes' do

      it 'does not save the question to the database' do
        expect{ post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_question), format: :js

      end

    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create (:answer) }

    context 'As an author' do
      before { sign_in answer.user }

      it 'deletes the requested answer from the database' do
        expect{ delete :destroy, id: answer }.to change(Answer, :count).by(-1)
      end

      it 'redirect_to question show view' do
        question = answer.question
        delete :destroy, id: answer
        expect(response).to redirect_to question
      end

    end

    context 'As not an author' do
      let(:non_author) { create (:user) }
      before { sign_in non_author }

      it 'not deletes the requested answer from the database' do
        expect{ delete :destroy, id: answer }.to_not change(Answer, :count)
      end

      it 'render question path' do
        delete :destroy, id: answer
        expect(response).to redirect_to answer.question
      end

    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question) }

    it 'assigns the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'changes answer`s attributes`' do
      patch :update, id: answer, question_id: question, answer: { body: 'new body'}, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end

  end

  describe 'PATCH #make_best' do
    let!(:answers_list) { create_list(:answer, 3, question: question, best: 'false') }
    let!(:answer) { create(:answer, question: question, best: 'true') }

    it 'assigns the requested answer to @answer' do
      patch :make_best, id: answer, question_id: question, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'sets all answer`s best attribute values to false`' do
      patch :make_best, question_id: question, format: :js
      expect( assigns(:answers) ).to match_array(answers)
    end

    it 'sets answer`s best attribute value to true`' do
      patch :make_best, id: answer, question_id: question, format: :js
      answer.reload
      expect(answer.best).to eq 'true'
    end

    it 'render make best' do
      patch :make_best, id: answer, question_id: question, format: :js
      expect(response).to render_template :make_best
    end
  end

end
