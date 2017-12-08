class UsersController < AccountCreationAndLoginController
  skip_before_filter :stop_logged_in_users, only: [:destroy]

  def show
    @user = User.new
  end

  def create
    @user = create_user

    # Check if all inputs are correct
    if @user.valid? == false
      render :show
      return
    end

    # if a user exists
    if User.find_by(email: @user.email)
      @user.errors.add :base, "Email is already in use."
      render :show
      return
    end

    @user.save
    session[:user_id] = @user.id
    redirect_to "/", notice: "Account succesfully created, welcome!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", notice: "Logged out succesfully!"
  end

  def orders
    orders = @user.orders

  end

  private
    # create and return a new user
    def create_user
      user_params = params.require(:user).permit(:first_name, :last_name, :email, :password)
      user = User.new first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], password: ''
      user.password = user_params[:password]
      user
    end

end
