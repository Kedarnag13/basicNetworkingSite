class MembersController < ApplicationController

  before_action :authorize, except: [:new, :create]

  def index
    @members = Member.where.not(id: current_user.id)
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
    @member = Member.new(name: params[:name], original_url: params[:original_url], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    @member.shortened_url = lets_shorten_url.short_url
    # @member.password = generate_random_password
    if @member.valid?
      @member.save
      # RegistrationsMailer.send_password(@member).deliver_now
      redirect_to root_path
    end
  end

  def add_as_friend
    friends_with = Member.find(params[:id])
    unless current_user.friends_with?(friends_with)
      current_user.friend_request(friends_with)
      friends_with.accept_request(current_user)
    end
    redirect_to members_path
  end

  def remove_friend
    friends_with = Member.find(params[:id])
    if current_user.friends_with?(friends_with)
      friends_with.remove_friend(current_user)
    end
    redirect_to members_path
  end

  def my_profile
    respond_to do |format|
      format.html
    end
  end

  def search
    @members = Member.where('lower(name) LIKE ? OR upper(name) LIKE ?', "%#{params[:member_name]}%", "%#{params[:member_name]}%")
    @results = @members.map { |member| member if member.name != current_user.name }
  end

  private

  def lets_shorten_url
    shortened_url = Bitly.client.shorten(params[:original_url])
  end

  # def generate_random_password
  #   SecureRandom.alphanumeric(5)
  # end
  

end