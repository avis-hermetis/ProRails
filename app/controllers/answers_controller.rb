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
    if current_user && current_user.author_of(@answer)
      @answer.destroy
      @notice = "Answer succesfully deleted!"
    else
      @notice = "You are not author"
    end

    redirect_to @answer.question, notice: @notice


  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
   params.require(:answer).permit(:body)
  end

end
