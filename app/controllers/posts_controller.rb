class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def show
    @post = Post.find(params[:id])
  end
  
  
  def new
    @post = current_user.posts.build
  end
  
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save!
      flash[:success] = "投稿しました！"
      redirect_to @post
    else
      flash.now[:danger] = "投稿に失敗しました！"
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    
    if @post.update(post_params)
      flash[:success] = "編集しました！"
      redirect_to @post
    else
      flash.now[:danger] = "編集に失敗しました！"
      render :edit
    end
  end
  
  
  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to users_path
  end
  
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :image).merge(user_id: current_user.id)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    
    unless @post
      redirect_to users_path
    end
  end
  
  
end
