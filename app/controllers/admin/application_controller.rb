module Admin
  class ApplicationController < ::ApplicationController
    before_action :only_admin

    private

    def only_admin
      if !user_signed_in? || current_user.admin == false
        redirect_to new_user_session_path, danger: "Vous n'avez pas le droit d'accéder à cette page"
      end
    end
  end
end
