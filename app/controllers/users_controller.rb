class UsersController < ApplicationController
  before_action :logged_in_user, only: [:following, :followers]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  # 自分がフォローしているユーザ
  def following
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
  end

  # 自分をフォローしているユーザ
  def followers
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password,
                                 :password_confirmation, :image)
  end
end
