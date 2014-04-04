class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :calendar_news,  :calendar_date, :footer_images
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def calendar_news
     News.all
  end

  def calendar_date
    params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
  end

  def footer_images
    Image.last(3)
  end
end
