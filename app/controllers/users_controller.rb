class UsersController < ApplicationController
  def show
    @user = User.new
  end

  def login
    @user = User.new
  end

  # post route for logging in
  def create_session
    @user = find_user
    if @user == nil or @user == false
      @user = User.new
      @user.errors.add(:base, "E-mail or password did not match our records")
      render :login
      return
    end
    session[:user_id] = @user.id
    redirect_to "/"
  end

  # post route for making a new user
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
    redirect_to "/"
  end

  def logout
    session[:user_id] = nil
    redirect_to "/"
  end

  private
    # create and return a new user
    def create_user
      user_params = params.require(:user).permit(:first_name, :last_name, :email, :password)
      user = User.new first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], password: ''
      user.password = user_params[:password]
      user
    end

    # find a user, for logging in.
    def find_user
      user_params = params.require(:user).permit(:email, :password)
      User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])
    end
end
