class Api::V1::TaskCommentsController < ApplicationController
  def create 
    service = TaskCommentService.new
    service.create(current_user, params[:task_id], params[:comment])
    if service.errors.present?
      render json: { error: service.errors }, status: :unprocessable_entity
    else
      render json: { message: 'Comment successfully added' }, status: :created
    end
  end
end
