class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :item_type, :weight
end
