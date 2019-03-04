class EstimateSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin_lat, :origin_lng, :origin_administrative, :origin_address, :destination_lat, :destination_lng, :destination_administrative, :destination_address, :estimate, :distance
end
