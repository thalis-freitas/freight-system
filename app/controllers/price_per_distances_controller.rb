class PricePerDistancesController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only:[:new, :create, :edit, :update]
  before_action :set_price_per_distance, only:[:edit, :update]
  before_action :list_mode_of_transports, only:[:new, :edit]
  
  def new 
    @price_per_distance = PricePerDistance.new
  end
  
  def create
    @price_per_distance = PricePerDistance.new(price_per_distance_params)
    @mode_of_transport = @price_per_distance.mode_of_transport
    if @price_per_distance.save
      redirect_to @mode_of_transport, notice: "#{t(:distance_pricing_setup, count:1).capitalize} #{t(:successfully_registered)} #{t :for_the_modality} #{@mode_of_transport.name}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} a #{t(:distance_pricing_setup, count:1)}"
      @mode_of_transports = ModeOfTransport.order(:name)
      render :new
    end
  end

  def edit; end

  def update 
    if @price_per_distance == price_per_distance_params
      flash.now[:alert] = "#{t(:no_modification_found)}"
      render :edit
    elsif @price_per_distance.update(price_per_distance_params)
      redirect_to mode_of_transport_path(@price_per_distance.mode_of_transport), notice: "#{t(:distance_pricing_setup, count:1).capitalize} #{t :successfully_updated}"
    else
      flash.now[:alert] = "#{t(:unable_to_update)} a #{t(:distance_pricing_setup, count:1)}" 
      render :edit
    end
  end

  private 

  def price_per_distance_params
    params.require(:price_per_distance).permit(:minimum_distance, :maximum_distance, :rate, :mode_of_transport_id)
  end

  def admins_only
    unless current_user.admin?
      return redirect_to root_path, alert: t(:unauthorized_access)
    end
  end

  def set_price_per_distance
    @price_per_distance = PricePerDistance.find(params[:id])
  end

  def list_mode_of_transports
    @mode_of_transports = ModeOfTransport.order(:name)
  end
end