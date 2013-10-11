class RailsUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  belongs_to :contact
  belongs_to :lead

  def self.match_contact_by_email(email)
  	Contact.find_by_email(email)
  end

  def self.match_lead_by_email(email)
  	Lead.find_by_email(email)
  end

  def salesforce_name
  	if self.contact
  		"#{self.contact.firstname} #{self.contact.lastname}"
  	elsif self.lead
  		"#{self.lead.firstname} #{self.lead.lastname}"
  	else
  		""
  	end
  end

  def salesforce_id
  	self.contact ? self.contact.sfid : (self.lead ? self.lead.sfid : nil)
  end

  def sf_error
  	if self.contact
  		self.contact.cc_last_error
  	elsif self.lead
  		self.lead.cc_last_error
  	end
  end
  
  def after_confirmation
  	if self.contact.nil? && self.lead.nil?
  		puts "No associated contact or lead"
  		self.contact = RailsUser.match_contact_by_email(self.email)
  		if self.contact.nil?
  			self.lead = RailsUser.match_lead_by_email(self.email)
  		end
  		if self.contact.nil? && self.lead.nil?
  			puts "Create a new lead"
  			# Create a new Lead for this user
  			self.lead = Lead.create(:email => self.email)
  		end
  		save()
  	end
  end

end
