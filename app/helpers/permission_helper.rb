module PermissionHelper
  
  def isAdmin?
    user_signed_in? && current_user.admin == true
  end
end
