require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'GET #new' do
   before  do
     sign_in user
     get :new, question_id: question
   end

   it 'assigns the Question to the variable @question' do
    expect(assigns(:question)).to eq question
   end

   it 'assigns a new answer to the variable @answer' do
    expect(assigns(:answer)).to be_a_new(Answer)
   end

   it 'renders new view' do
     expect(response).to render_template :new
   end
  end

  describe 'POST #create' do
    let(:answer) { build(:answer) }

    before  do
      sign_in user
    end


    context 'with valid attributes do' do

      it 'saves the new answer to the database' do
        expect{ post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'connects the answer with the current user' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(assigns(:answer).user.id).to eq controller.current_user.id
      end

      it 'redirects to show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end

    end

    context 'with invalid attributes' do

      it 'does not save the question to the database' do
        expect{ post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_question)
        expect(response).to render_template :new
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
end
