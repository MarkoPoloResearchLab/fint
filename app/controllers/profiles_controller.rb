class ProfilesController < ApplicationController
  before_action :get_table_data, only: :index
  def index
    @headers.unshift "", "Favs"
    @content.each{ |row| row.unshift 'View', "" }
  end
end
