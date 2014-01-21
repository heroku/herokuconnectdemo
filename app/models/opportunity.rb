 class Opportunity < SalesforceModel
  self.table_name =  'opportunity'

  attr_protected :CreatedDate, :SystemModstamp, :LastModifiedDate
end
