class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :success

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if current_user
      true
    else
      redirect_to new_user_session_path, notice: "You must be logged in to access that page."
    end
  end

  def render_404
    respond_to do |format|
      format.html do
        render file: 'public/404.html', status: :not_found, layout: false
      end
      format.json do
        render status: 404, json: {
          message: "Not found."
        }
      end
    end
  end

end
