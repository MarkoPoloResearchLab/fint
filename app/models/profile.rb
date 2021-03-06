require 'csv'
require 'active_model'

class Profile
  include ActiveModel::Model
  
  class << self
    def array
      # CSV.read('sources/table_sample.csv')
      CSV.read('sources/large_table.csv')
    end

    def content
      table_data
      # .each{|r| r}
    end

    def headers
      table_data.headers
    end

    private
      def table_data
        CSV.read('sources/table_sample.csv', headers: :first_row, skip_blanks: true)
      end
  end
  
end
