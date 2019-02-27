class Client < ApplicationRecord
  has_many :items
  has_many :movings
  has_many :movers, :through => :movings
  has_secure_password

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :name
  validates_uniqueness_of :email
  validates :password, :presence => true, :length => {:within => 6..40}
end
