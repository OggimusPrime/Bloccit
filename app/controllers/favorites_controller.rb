class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.build(post: @post)
    authorize @favorite

    if @favorite.save
      flash[:notice] = 'You have favored this post.'
      redirect_to [@post.topic, @post]
    else
      flash[:errpr] = 'There was an error favoring this post.'
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find(params[:id])
    authorize @favorite

    if @favorite.destroy
      flash[:notice] = 'You have unfavored this post.'
      redirect_to [@post.topic, @post]
    else
      flash[:error] = 'There was an error unfavoring this post.'
      redirect_to [@post.topic, @post]
    end
  end
end
