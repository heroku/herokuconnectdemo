class SalesforceModel < ActiveRecord::Base
    self.abstract_class = true
    self.inheritance_column = 'rails_type'

    if ENV['HEROKUCONNECT_URL'].nil?
    	puts "WARNING: YOU SHOULD SET HEROKUCONNECT_URL IN YOUR ENVIRONMENT"
    end
    if ENV['HEROKUCONNECT_SCHEMA'].nil?
    	puts "WARNING: YOU SHOULD SET HEROKUCONNECT_SCHEMA IN YOUR ENVIRONMENT"
    end

    establish_connection ENV['HEROKUCONNECT_URL']
	attr_protected :createddate, :systemmodstamp, :lastmodifieddate

	def hc_errors
		HerokuconnectTriggerLog.where(:record_id => self.id, :state => 'FAILED').order("id DESC").all	
	end	

	def hc_last_error
		errs = cc_errors()
		if errs[0]
			errs[0].sf_message
		else
			nil
		end
	end
end

class HerokuconnectTriggerLog < SalesforceModel
	self.table_name = '_trigger_log'

	def self.pending
		HerokuconnectTriggerLog.where(:state => 'NEW').count
	end

end
