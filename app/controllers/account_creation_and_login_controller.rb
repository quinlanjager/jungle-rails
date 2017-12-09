class AccountCreationAndLoginController < ApplicationController
  before_filter :stop_logged_in_users


  private
    def stop_logged_in_users
      if @user
        redirect_to("/")
      end
    end
end
