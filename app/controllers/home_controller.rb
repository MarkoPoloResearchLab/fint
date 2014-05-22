class HomeController < ApplicationController
  before_action :get_table_data, only: :index
  respond_to :js, :html
  def index    
    respond_to do |format|
      format.html{ render '_index' }
      format.js{ render 'index' }
    end
  end
end
