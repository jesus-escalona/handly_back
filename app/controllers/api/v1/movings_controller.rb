class Api::V1::MovingsController < ApplicationController
  skip_before_action :authorized, :only => [:reviews, :estimate]

  def reviews
    @movings = Moving.first(5)
    render json: { reviews: MovingSerializer.new(@movings) }, status: :accepted
  end

  def estimate
    origin = estimate_params[:origin]
    destination = estimate_params[:destination]
    @move_type = MoveType.find(estimate_params[:move_type])

    @distance = Moving.get_distance(origin[:latlng], destination[:latlng])
    if @distance == -1
      render json: { error: "We could not calculate a route between these points"}
      return
    end

    @estimate = Moving.get_estimate(@distance, @move_type)
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
        move_type_id: @move_type.id
        )

    @movers = Mover.super_query
    render json: { moving_estimate: EstimateSerializer.new(@moving), companies: MoverSerializer.new(@movers) }, status: :accepted
  end

  def create
    create_moving_params[:client] = @client
    create_moving_params[:status] = 'pending'
    create_moving_params[:moving_rating] = 0
    @mover = Mover.find(create_moving_params[:mover_id])
    final_price = (@mover[:bid_factor] * create_moving_params[:estimate].to_i).round(2)
    create_moving_params[:final_price] = final_price

    @moving = Moving.new(create_moving_params)
    if @moving.save
      render json: {message: 'Moving Booked!'}, status: :ok
    else
      render json: { error: @moving.errors.full_messages }, status: :not_acceptable
    end

  end

  def update
    @moving = Moving.find(params[:id])
    rating = rating_params[:rating].to_i
    review = rating_params[:review]
    if @moving.client == @client
      if @moving.update(moving_rating: rating, moving_review: review)
        render json: { client: ClientSerializer.new(@client), movings: MovingCreatorSerializer.new(@client.movings) }, status: :accepted
      else
        render json: {message: @moving.errors.full_messages }, status: :not_acceptable

      end
    else
      render json: {message: 'So what are you exactly trying to do?'}, status: :not_acceptable
    end
  end

  private

  def estimate_params
    params.permit(
        :move_type,
        :origin => [:administrative, :name, latlng: [:lat, :lng]],
        :destination => [:administrative, :name, latlng: [:lat, :lng]]
    )
  end

  def create_moving_params
    params.require(:moving).permit!
  end

  def rating_params
    params.permit(:rating, :review)
  end

end
