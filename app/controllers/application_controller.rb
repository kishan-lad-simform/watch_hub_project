class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_dashboard_index_path 
    elsif current_user.normal_user?
      posts_path
    else
      new_user_registration_path
    end
  end
end
