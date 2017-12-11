class LoginsController < AccountCreationAndLoginController

  def show
    @user = User.new
  end

  # post route for logging in
  def create
    user_params = params.require(:user).permit(:email, :password)

    @user = User.authenticate_with_credentials(user_params[:email], params[:password])

    if user_params[:email].length == 0 or user_params[:password].length == 0
      @user = User.new
      @user.errors.add(:base, "Both an e-mail and a password are required")
      render :show
      return
    end

    if not @user
      @user = User.new
      @user.errors.add(:base, "E-mail or password did not match our records")
      render :show
      return
    end


    session[:user_id] = @user.id
    redirect_to "/", notice: "Login successful!"
  end

end
