class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page])
    @my_posts = current_user.posts.order(id: :desc).page(params[:page])
    @fav_posts = current_user.likes.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "ユーザーを登録しました"
      redirect_to users_path
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました"
      render :new
    end    
  end
  
  def my_posts
    @my_posts = current_user.posts.order(id: :desc).page(params[:page])
  end

  def fav_posts
    @fav_posts = current_user.likes.order(id: :desc).page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
