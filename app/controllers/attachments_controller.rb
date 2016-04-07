class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attachment = Attachment.find(params[:id])
    if current_user && current_user.author_of?(@attachment.attachable)
      @attachment.destroy
      @notice = "File succesfully deleted!"
    else
      @notice = "You are not author"
    end

  end

end