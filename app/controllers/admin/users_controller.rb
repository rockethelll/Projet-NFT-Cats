module Admin
  class UsersController < ApplicationController
    def index
      @users = User.order(id: :asc)
    end

    def show
      @user = User.find(params[:id])
      redirect_to admin_users_path
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if params[:admin] == true
        @user.update(admin: true)
        @user.update! user_params
        redirect_to admin_users_path
      else
        @user.update(admin: false)
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:success] = "L'utilisateur a bien été supprimé"
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(:id, :email, :admin)
    end
  end
end
