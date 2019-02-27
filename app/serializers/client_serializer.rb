class ClientSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :avatar, :email, :email_verified, :phone_number
end