class PagesController < ApplicationController
  def home
    if logged_in?
      @users = current_user.followings
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
