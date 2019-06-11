class SessionsController < ApplicationController

    def new
      @user = User.new
      render :new
    end

    def create
      debugger
      @user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
      )
      
      if @user
        login(@user)
        redirect_to links_url
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new
      end
    end
end
