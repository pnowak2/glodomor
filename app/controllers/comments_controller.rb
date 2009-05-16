class CommentsController < ApplicationController

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment]) if @commentable
    if @commentable && @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to :controller => @commentable.class.name.pluralize, :action=> 'show', :id => @commentable.id
    else
      flash[:notice] = "Couldn't create comment for that product"
      redirect_to root_path
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
