class WelcomeController < ApplicationController
  
  def index
    @members = Member.all
  end

  def search
    @members = Member.where('lower(name) LIKE ? OR upper(name) LIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
    @headings = Heading.where('lower(heading) LIKE ? OR upper(heading) LIKE ?', "%#{params[:term]}%", "%#{params[:term]}%")
    @results = @members + @headings
    @results.uniq
  end

end