class HomeController < ApplicationController
  respond_to :js, :html
  def index
    @data = Profile.array
    
    respond_to do |format|
      format.html{ render '_index' }
      format.js{ render 'index' }
    end
  end
end
