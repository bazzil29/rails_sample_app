class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to sample app!"
      redirect_to user_url(@user)
    else
      render 'users/new'
    end
  end

  def edit
    @user =  User.find(params[:id])    
  end

  def update 
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      redirect_to @user
    else
      render 'users/edit'
    end
  end

  def show
    @user =  User.find(params[:id])   
  end

  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
#before filter
#Confirm a logged_in user
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

#Comfirm logged as a correct user  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
