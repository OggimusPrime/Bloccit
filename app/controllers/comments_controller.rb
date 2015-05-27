class CommentsController < ApplicationController
  respond_to :html

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new
    authorize @comment

    comment_create
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment

    comment_destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  # Moved .save and .destroy to reduce lines in controller actions
  def comment_create
    if @comment.save
      flash[:notice] = 'Comment was created.'
    else
      flash[:error] = 'There was an error saving the comment. Please try again.'
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def comment_destroy
    if @comment.destroy
      flash[:notice] = 'Comment was removed.'
    else
      flash[:error] = "Comment couldn't be deleted. Try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
