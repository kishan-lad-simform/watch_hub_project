class Admin::DashboardController < Admin::BaseController
  before_action :check_admin_role
  def index
  end

  def profile
    @user = User.find(current_user.id)  
  end

  private
    def check_admin_role
      unless current_user&.has_role?(:admin)
        flash.now[alert] = "Access Denied for user to access admin page."
        redirect_to root_path
      end
    end

    def profile_params
      params.require(:user)
        .permit( 
          :firstname, 
          :lastname, 
          :contact, 
          addresses_attributes: [
            :country,
            :state,
            :city,
            :street,
            :flat_no,
            :pincode
          ]
        )
    end
end