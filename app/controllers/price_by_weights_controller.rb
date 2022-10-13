class PriceByWeightsController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only:[:new, :create, :edit, :update]
  before_action :set_mode_of_transport, only:[:new, :edit, :create, :update]
  before_action :set_price_by_weight, only:[:edit, :update]

  def new
    @price_by_weight = PriceByWeight.new
  end

  def create
    @price_by_weight = PriceByWeight.new(price_by_weight_params)
    @price_by_weight.mode_of_transport = @mode_of_transport
    if @price_by_weight.save
      redirect_to @mode_of_transport, notice: "#{t(:price_by_weight_setting, count:1).capitalize} #{t(:successfully_registered)}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} a #{t(:price_by_weight_setting, count:1)}"
      render :new
    end
  end

  def edit; end

  def update
    if @price_by_weight == price_by_weight_params
      flash.now[:alert] = "#{t(:no_modification_found)}"
      render :edit
    elsif @price_by_weight.update(price_by_weight_params)
      redirect_to mode_of_transport_path(@mode_of_transport), notice: "#{t(:price_by_weight_setting, count:1).capitalize} #{t :successfully_updated}"
    else
      flash.now[:alert] = "#{t(:unable_to_update)} a #{t(:price_by_weight_setting, count:1)}" 
      render :edit
    end
  end

  private 

  def admins_only
    unless current_user.admin?
      return redirect_to root_path, alert: t(:unauthorized_access)
    end
  end

  def set_price_by_weight
    @price_by_weight = PriceByWeight.find(params[:id])
    @price_by_weight.mode_of_transport = @mode_of_transport
  end

  def set_mode_of_transport
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
  end

  def price_by_weight_params
    params.require(:price_by_weight).permit(:minimum_weight, :maximum_weight, :value)
  end
end