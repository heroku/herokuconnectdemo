# Generate interleaved inserts

400.times do
	Account.create(:name => "Big Co 600")
	Contact.create(:firstname => 'Dr', :lastname=>'Rosenpenis')
	Lead.create(:name=>'Scott Persinger')		
	Opportunity.create(:name => "This is a great chance at a sale", :stagename=>'Prospecting', :closedate=>'2013-12-31')
end
