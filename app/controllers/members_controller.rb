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
    @member = Member.new(name: params[:name], original_url: params[:original_url])
    @member.shortened_url = lets_shorten_url.short_url
    if @member.valid?
      @member.save
      redirect_to members_path
    end
  end

  private

  def lets_shorten_url
    shortened_url = Bitly.client.shorten(params[:original_url])
  end

end