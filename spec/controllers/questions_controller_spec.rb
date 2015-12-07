require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe  'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'populates an array of all questions' do
      expect( assigns(:questions) ).to match_array(questions)
    end

    it 'renders index view' do
      expect(response). to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create (:question) }
    before { get :show, id: question }

    it 'assigns the requested question to @question ' do
      expect( assigns(:question) ).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    let(:question){build(:question)}


    context 'with valid attributes do' do

      it 'saves the new question in the database' do
        expect{ post :create, user_id: @user, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'connects the question with the current user' do
        post :create, question: attributes_for(:question)
        expect(assigns(:question).user.id).to eq controller.current_user.id
      end

      it 'redirects to show view' do
        post :create, user_id: @user, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end

    end

    context 'with invalid attributes' do

      it 'does not save the question to database' do
        expect{ post :create, user_id: @user, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, user_id: @user, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end

    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create (:question) }

    context 'As an author' do
      before { sign_in question.user }

      it 'deletes the requested question from the database' do
        expect{ delete :destroy, id: question }.to change(Question, :count).by(-1)
      end

      it 'redirect_to index view' do
        delete :destroy, id: question
        expect(response).to redirect_to questions_path
      end

    end

    context 'As not an author' do
      let(:non_author) { create (:user) }
      before { sign_in non_author }

      it 'not deletes the requested question from the database' do
        expect{ delete :destroy, id: question }.to_not change(Question, :count)
      end

      it 'render question path' do
        delete :destroy, id: question
        expect(response).to redirect_to question
      end

    end
  end
end

