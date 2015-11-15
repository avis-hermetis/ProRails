require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
   before  do
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

    context 'with valid attributes do' do

      it 'saves the new answer to the database' do
        expect{ post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
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

end
