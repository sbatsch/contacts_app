class Contact < ApplicationRecord
  def full_name
    "#{self.first_name} #{self.last_name}"
  end  

  def friendly_updated_at
     updated_at.strftime("%b, %d, %Y")
  end   
end
