class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
      @user = User.new email: user_params[:email], password: ''
      @user.password = user_params[:password]
      if @user.valid? == false
        render :new
      else
        @user.save
        redirect_to "/"
      end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
