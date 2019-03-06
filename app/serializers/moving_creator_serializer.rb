class MovingCreatorSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin_lat, :origin_lng, :origin_administrative, :origin_address, :destination_lat, :destination_lng, :destination_administrative, :destination_address, :moving_rating, :moving_review, :estimate, :final_price, :distance, :move_type, :mover, :status, :moving_time
end
