class Api::ContactsController < ApplicationController
  def one_contact_action
    @contact = Contact.first 
    render 'one_contact_view.json.jb'
  end 

  def all_contacts
    @contacts = Contact.all
    render 'all_contacts.json.jb'
  end
end
