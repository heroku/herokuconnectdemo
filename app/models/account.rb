class Account < SalesforceModel
  self.table_name =  ENV['HEROKUCONNECT_SCHEMA'] + '.account'

  has_many :contacts, :primary_key => "sfid", :foreign_key => "accountid"

  attr_protected :CreatedDate, :SystemModstamp, :LastModifiedDate
end
