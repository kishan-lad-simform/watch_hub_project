class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
  end

  private
    def check_admin_role
      unless current_user&.has_role?(:admin)
        redirect_to root_path, alert: "Access Denied for user to access admin page."
      end
    end
end