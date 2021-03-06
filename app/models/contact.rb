class Contact < ApplicationRecord
  belongs_to :user

  has_many :contact_groups
  has_many :groups, through: :contact_groups


  validates :first_name, presence: true 
  validates :last_name, presence: true 
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  def full_name
    "#{self.first_name} #{self.last_name}"
  end  

  def friendly_updated_at
     updated_at.strftime("%b, %d, %Y")
  end   
end
