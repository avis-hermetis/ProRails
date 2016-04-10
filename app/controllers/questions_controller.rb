class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question_load, only:[:show, :destroy, :update]

  def index
    @questions = Question.all
  end

  def show
  @answer = @question.answers.build
  @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
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
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path
    else
      redirect_to @question, notice: 'You are not the author'
    end
  end

  def update
    @question.update(question_params)
  end


  private

  def question_load
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end

end
