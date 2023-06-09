class RoleConstraint
  def matches?(request)
    @current_user = request.env['warden'].user
  end
  
  def is_admin?
    @current_user && @current_user.has_role?(:admin)
  end

  def is_user?
    @current_user && @current_user.has_role?(:user)
  end
end