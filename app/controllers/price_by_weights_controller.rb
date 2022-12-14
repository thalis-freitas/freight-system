class PriceByWeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only: %i[new create edit update]
  before_action :set_mode_of_transport_id, only: %i[new edit create update]
  before_action :set_price_by_weight, only: %i[edit update]

  def new
    @price_by_weight = PriceByWeight.new
  end

  def edit; end

  def create
    @price_by_weight = PriceByWeight.new(price_by_weight_params)
    @price_by_weight.mode_of_transport = @mode_of_transport
    if @price_by_weight.save
      redirect_to @mode_of_transport,
                  notice: t(:price_by_weight_successfully_registered)
    else
      flash.now[:alert] = t(:unable_to_register_price_by_weight)
      render :new
    end
  end

  def update
    if @price_by_weight == price_by_weight_params
      no_modification_found
    elsif @price_by_weight.update(price_by_weight_params)
      redirect_to mode_of_transport_path(@mode_of_transport),
                  notice: t(:price_by_weight_successfully_updated)
    else
      flash.now[:alert] = t(:unable_to_update_price_by_weight)
      render :edit
    end
  end

  private

  def set_price_by_weight
    @price_by_weight = PriceByWeight.find(params[:id])
    @price_by_weight.mode_of_transport = @mode_of_transport
  end

  def price_by_weight_params
    params.require(:price_by_weight).permit(:minimum_weight, :maximum_weight, :value)
  end
end
