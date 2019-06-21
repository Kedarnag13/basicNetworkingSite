class SessionsController < ApplicationController

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    member = Member.find_by(email: params[:email])
    if member && member.authenticate(params[:password])
      session[:user_id] = member.id
      flash[:success] = "Logged in successfully!"
      redirect_to members_path
    else
      flash.now[:danger] = "Invalid Email or Password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:success] = "Logged out!"
  end

end
