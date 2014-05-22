class ProfilesController < ApplicationController
  before_action :get_table_data, only: :index
end
