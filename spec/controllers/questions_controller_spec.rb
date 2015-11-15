require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe  'Get #index' do
    let(:questions) { create_list(:question, 2) }

    before do
    get :index
    end

    it 'populates an array of all questions' do
      expect( assigns(:questions) ).to match_array(questions)
    end

    it 'renders index view' do
      expect(response). to render_template :index
    end
  end

  describe 'Get #show' do
    let(:question) { create (:question) }

    before do
    get :show, id: question
    end

    it 'assigns the requested question to @question ' do
      expect( assigns(:question) ).to eq question
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'Get #new' do
    before {get :new}

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'Post #create' do

    context 'with valid attributes do' do

      it 'saves the new question in the database' do
        expect{ post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(asigns(:question))
      end

    end

    context 'with invalid attributes' do

      it 'does not save the question to database' do
        expect{ post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 'renders new view' do
        post :create, question: attributes_for(:question)
        expect(response).to render_template :new
      end

    end
  end

  describe 'Delete #destoy' do
    before do
      get :delete, id: question
    end

    it 'destroys the requested question from the database' do
    question
    expect{ delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

    it 'renders index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end

end

