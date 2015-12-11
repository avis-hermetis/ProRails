class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:new, :create]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer = Answer.find(params[:id])
    if current_user && current_user.author_of?(@answer)
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
   params.require(:answer).permit(:body, :question_id)
  end

end
