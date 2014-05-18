class ProfilesController < ApplicationController
  before_action :get_table, only: :index

  private
    def get_table
      @data = Profile.content
      @headers = Profile.headers
    end
end
