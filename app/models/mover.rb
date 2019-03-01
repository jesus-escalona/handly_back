class Mover < ApplicationRecord
  has_many :movings
  has_many :clients, through: :movings
  has_many :items, through: :clients


  def self.super_query
    Mover.select('movers.id', 'company_name', 'address', 'verified', 'logo', 'insured', 'AVG(movings.moving_rating) as "average_rating"')
        .joins(:movings).group('movers.id').order('average_rating')
  end

end
