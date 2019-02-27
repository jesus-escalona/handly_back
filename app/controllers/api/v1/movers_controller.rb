class Api::V1::MoversController < ApplicationController
  skip_before_action :authorized, :only => :index

  def index
    @movers = Mover.all
    render json: { companies: MoverSerializer.new(@movers) }, status: :accepted
  end
end
