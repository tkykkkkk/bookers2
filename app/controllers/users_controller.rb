class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index 
    @users = User.all
    @book = Book.new
  end 

  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books 
    @book = Book.new
  end


  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
    @user = User.find(params[:id])
  end 

  def update 
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="Userprofile is successfully updated"
      redirect_to user_path
    else
      render :edit
    end 
  end 

  private 
  
  def user_params
   params.require(:user).permit(:name, :profile_image, :introduction)
  end 

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end 
end 