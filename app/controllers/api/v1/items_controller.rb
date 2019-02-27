class Api::V1::ItemsController < ApplicationController
  def index
    @item = Item.all
    render json: { item: ItemSerializer.new(@item) }, status: :accepted
  end
end
