class Api::V1::MoveTypesController < ApplicationController
skip_before_action :authorized, only: [:index]

  def index
    @move_type = MoveType.all
    render json: { move_types: MoveTypeSerializer.new(@move_type) }, status: :accepted
  end
end
