class ClientSerializer
  include FastJsonapi::ObjectSerializer
  has_many :movings
  has_many :items

  attributes :name, :avatar, :email, :email_verified, :phone_number
end