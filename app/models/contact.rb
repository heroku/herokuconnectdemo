class Contact < SalesforceModel
  self.table_name =  'contact'
  belongs_to :account, :primary_key => 'sfid', :foreign_key => 'accountid'

  attr_protected :createddate, :systemmodstamp, :lastmodifieddate
end
