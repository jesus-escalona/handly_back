class Api::V1::MovingsController < ApplicationController
  skip_before_action :authorized, :only => [:reviews, :estimate]

  def reviews
    @movings = Moving.last(5)
    render json: { reviews: MovingSerializer.new(@movings) }, status: :accepted
  end

  def estimate
    origin = estimate_params[:origin]
    destination = estimate_params[:destination]
    moving_type = estimate_params[:move_type]

    @distance = Moving.get_distance(origin[:latlng], destination[:latlng])
    if @distance == -1
      render json: { error: "We could not calculate a route between these points"}
      return
    end

    @estimate = Moving.get_estimate(@distance, moving_type)
    if @estimate == 0
      render json: { error: "Options not found, please try again"}
      return
    end

    @moving = Moving.new(
        origin_lat: origin[:latlng][:lat],
        origin_lng: origin[:latlng][:lng],
        origin_administrative: origin[:administrative],
        origin_address: origin[:name],
        destination_lat: destination[:latlng][:lat],
        destination_lng: destination[:latlng][:lng],
        destination_administrative: destination[:administrative],
        destination_address: destination[:name],
        estimate: @estimate,
        distance: @distance,
        moving_type: moving_type
        )

    @movers = Mover.super_query
    render json: { moving_estimate: EstimateSerializer.new(@moving), companies: MoverSerializer.new(@movers) }, status: :accepted
  end

  private

  def estimate_params
    params.permit(
        :move_type,
        :origin => [:administrative, :name, latlng: [:lat, :lng]],
        :destination => [:administrative, :name, latlng: [:lat, :lng]]
    )
  end

end
