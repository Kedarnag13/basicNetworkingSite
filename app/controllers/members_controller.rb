class MembersController < ApplicationController

  def index
    @members = Member.all
    respond_to do |format|
      format.html
    end
  end
  
  def new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @member = Member.new(name: params[:name], original_url: params[:original_url], email: params[:email])
    @member.shortened_url = lets_shorten_url.short_url
    @member.password = generate_random_password
    if @member.valid?
      @member.save
      RegistrationsMailer.send_password(@member).deliver_now
      redirect_to members_path
    end
  end

  private

  def lets_shorten_url
    shortened_url = Bitly.client.shorten(params[:original_url])
  end

  def generate_random_password
    SecureRandom.alphanumeric(5)
  end
  

end