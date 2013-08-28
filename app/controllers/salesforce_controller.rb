class SalesforceController < ApplicationController

  def accounts
    @page = (params[:page] || 1).to_i
    @accounts = Account.order("name").offset(@page*20).limit(20).all()
  end

  def account
    if params[:id] =~ /^\d+$/
        @account = Account.find(params[:id])
    else
        @account = Account.find_by_sfid(params[:id])
    end

    begin
      @contacts = @account.contacts
    rescue
      @contacts = []
    end
  end

  def contacts
    @page = (params[:page] || 1).to_i
    @contacts = Contact.order("lastname").offset(@page*20).limit(20).all()
  end

end
