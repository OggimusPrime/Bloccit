module Topics
  class PostsController < ApplicationController
    def show
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:id])
      @comments = @post.comments.paginate(page: params[:page], per_page: 10)
      authorize @topic
    end

    def new
      @topic = Topic.find(params[:topic_id])
      @post = Post.new

      authorize @post
    end

    def create
      @topic = Topic.find(params[:topic_id])
      @post = current_user.posts.build(post_params)
      @post.topic = @topic

      authorize @post
      post_create
    end

    def edit
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:id])

      authorize @post
    end

    def update
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:id])

      authorize @post
      post_update
    end

    def destroy
      @topic = Topic.find(params[:topic_id])
      @post = Post.find(params[:id])

      authorize @post
      post_destroy
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    # Moved post.save .update & .destroy to reduce lines in controller actions
    def post_create
      if @post.save
        @post.initial_vote
        flash[:notice] = 'Post was saved.'
        redirect_to [@topic, @post]
      else
        flash[:error] = 'There was an error saving the post. Please try again.'
        render :new
      end
    end

    def post_update
      if @post.update_attributes(post_params)
        flash[:notice] = 'Post was updated.'
        redirect_to [@topic, @post]
      else
        flash[:error] = 'There was an error saving the post. Please try again.'
        render :edit
      end
    end

    def post_destroy
      title = @post.title
      if @post.destroy
        flash[:notice] = "\"#{title}\" was deleted successfully."
        redirect_to @topic
      else
        flash[:error] = 'There was an error deleting the post.'
        render :show
      end
    end
  end
end
