class UsersController < ApplicationController
  
 def index 
 @users = User.all
 @user = current_user
 @new_book = Book.new
 end 
 
 def show
   @new_book = Book.new
   @user = User.find(params[:id])
   @books = @user.books 
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

end 


