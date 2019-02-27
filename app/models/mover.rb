class Mover < ApplicationRecord
  has_many :moving
  has_many :clients, through: :movings
  has_many :items, through: :clients
end
