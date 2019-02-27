class MovingSerializer
  include FastJsonapi::ObjectSerializer
  attributes :moving_review, :moving_rating
  attribute :client do |object|
    "#{object.client.name}"
  end
  attribute :avatar do |object|
    "#{object.client.avatar}"
  end
end
