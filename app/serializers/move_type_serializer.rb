class MoveTypeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :icon
  attribute :text, &:moving_type
  attribute :value, &:move_value

end
