class WelcomeController < ApplicationController
  
  def index
  end

  def search
    @members = Member.where('name LIKE ?', "%#{params[:term]}%")
    @headings = Heading.where('heading LIKE ?', "%#{params[:term]}%")
    @results = @members + @headings
    @results.uniq
  end

end