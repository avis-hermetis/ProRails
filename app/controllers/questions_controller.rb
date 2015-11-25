class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question_load, only:[:show, :destroy]
  def index
    @questions = Question.all
  end

  def show

  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_load
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
