class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:new, :create]


  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question_id
    @answer.destroy if @answer.user == current_user

    redirect_to question_path(@question), notice: 'The answer was successfully deleted'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    @answer_params = params.require(:answer).permit(:body)
    @answer_params.merge(user: current_user) if current_user
  end
end
