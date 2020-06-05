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

  # 自分がフォローしているユーザの一覧
  def following
    @user  = User.find(params[:id])
    @users = @user.followings.paginate(page: params[:page])
    render 'show_follow'
  end

  # 自分をフォローしているユーザの一覧
  def followers
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password,
                                 :password_confirmation, :image)
  end
end
