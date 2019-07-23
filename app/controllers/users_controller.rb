class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # log_in @user
      # flash[:success] = "Welcome to sample app!"
      # redirect_to user_url(@user)
    else
      render 'users/new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
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
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

#Comfirm logged as a correct user  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

#Comfirm logged as a admin user

def admin_user
  redirect_to(root_url) unless current_user.admin?
end

end
