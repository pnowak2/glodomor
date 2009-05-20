class CommentsController < ApplicationController

  before_filter :require_user

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment]) if @commentable
    @comment.user = current_user if current_user
    if @commentable && @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @commentable
    else
      flash[:notice] = "Couldn't create comment for that item"
      redirect_to @commentable
    end
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        begin
          return $1.classify.constantize.find(value)
        rescue
          nil
        end
      end
    end
    nil
  end
  
end
