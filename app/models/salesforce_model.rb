class SalesforceModel < ActiveRecord::Base
    self.abstract_class = true
    self.inheritance_column = 'rails_type'

    if ENV['CLOUDCONNECT_URL'].nil?
    	puts "WARNING: YOU SHOULD SET CLOUDCONNECT_URL IN YOUR ENVIRONMENT"
    end

    establish_connection ENV['CLOUDCONNECT_URL']
	attr_protected :createddate, :systemmodstamp, :lastmodifieddate

	def cc_errors
		CloudconnectTriggerLog.where(:record_id => self.id, :state => 'FAILED').order("id DESC").all	
	end	

	def cc_last_error
		errs = cc_errors()
		if errs[0]
			errs[0].sf_message
		else
			nil
		end
	end
end

class CloudconnectTriggerLog < SalesforceModel
	self.table_name = '_trigger_log'

	def self.pending
		CloudconnectTriggerLog.where(:state => 'NEW').count
	end

end
