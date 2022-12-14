class PricePerDistancesController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only: %i[new create edit update]
  before_action :set_price_per_distance, only: %i[edit update]
  before_action :set_mode_of_transport_id, only: %i[new edit create update]

  def new
    @price_per_distance = PricePerDistance.new
  end

  def edit; end

  def create
    @price_per_distance = PricePerDistance.new(price_per_distance_params)
    @price_per_distance.mode_of_transport = @mode_of_transport
    if @price_per_distance.save
      redirect_to @mode_of_transport,
                  notice: t(:price_per_distance_successfully_registered)
    else
      flash.now[:alert] = t(:unable_to_register_price_per_distance)
      render :new
    end
  end

  def update
    if @price_per_distance == price_per_distance_params
      no_modification_found
    elsif @price_per_distance.update(price_per_distance_params)
      redirect_to mode_of_transport_path(@price_per_distance.mode_of_transport),
                  notice: t(:price_per_distance_successfully_updated)
    else
      flash.now[:alert] = t(:unable_to_update_price_per_distance)
      render :edit
    end
  end

  private

  def price_per_distance_params
    params.require(:price_per_distance).permit(:minimum_distance, :maximum_distance, :rate, :mode_of_transport_id)
  end

  def set_price_per_distance
    @price_per_distance = PricePerDistance.find(params[:id])
  end
end
