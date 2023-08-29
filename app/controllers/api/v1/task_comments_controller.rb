class Api::V1::TaskCommentsController < ApplicationController
  def create 
    service = TaskCommentService.new
    service.create(comment_params)
    if service.errors.present?
      render json: { success: false, error: service.errors }, status: :unprocessable_entity
    else
      render json: { success: true, message: 'Comment successfully added' }, status: :created
    end
  end

  private def comment_params
    params.require(:task_comment).permit(:task_id, :body).merge(user: current_user)
  end
end
