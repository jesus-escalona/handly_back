class MoveTypeSerializer
  include FastJsonapi::ObjectSerializer
  attribute :text, &:moving_type
  attribute :value, &:id

end
