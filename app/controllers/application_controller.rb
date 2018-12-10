class ApplicationController < ActionController::Base
  before_action :require_sing_in!
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_sing_in!
    flash[:notice] = "ログインしてください"
    redirect_to new_session_path
  end
end
