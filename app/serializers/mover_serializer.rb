class MoverSerializer
  include FastJsonapi::ObjectSerializer
  attributes :company_name, :logo, :insured, :average_rating
  attribute :reputation do |object|
    object.movings.map do |moving|
      {
          rating: moving.moving_rating,
          review: moving.moving_review
      }
    end
  end
end
