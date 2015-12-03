class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question_load, only:[:show, :destroy]
  def index
    @questions = Question.all
  end

  def show
    @answers = @question.answers
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    if current_user && current_user == @question.user
      @question.destroy
      redirect_to questions_path
    else
      redirect_to @question, notice: 'You are not the author'
    end
  end

  private

  def question_load
    @question = Question.find(params[:id])
  end

  def question_params
    question_params = params.require(:question).permit(:title, :body)
    question_params.merge(user: current_user) if current_user
  end
end
