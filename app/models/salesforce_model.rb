class SalesforceModel < ActiveRecord::Base
    self.abstract_class = true
    self.inheritance_column = 'rails_type'

    establish_connection ENV['CLOUDCONNECT_URL']
end
