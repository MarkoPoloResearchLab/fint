class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def get_table_data
      data = Profile.array
      @headers = data.shift
      @content = data
    end
end
