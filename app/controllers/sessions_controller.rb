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
      redirect_to members_path, notice: 'Logged in successfully!'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end

end
