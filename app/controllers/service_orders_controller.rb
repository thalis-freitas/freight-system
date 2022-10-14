class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_order, only:[:show, :edit, :update]
  before_action :formatted_recipient_phone, only:[:show]
  before_action :admins_only, only:[:new, :create, :edit]

  def new 
    @service_order = ServiceOrder.new
  end

  def create 
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to @service_order, notice: "#{ServiceOrder.model_name.human} #{t(:successfully_registered)}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} a #{ServiceOrder.model_name.human}"
      render :new
    end
  end

  def update 
    if @service_order == service_order_params
      flash.now[:alert] = "#{t(:no_modification_found)}"
      render :new
    elsif @service_order.update(service_order_params)
      redirect_to service_order_path(@service_order), notice: "#{ServiceOrder.model_name.human} #{t :successfully_updated}"
    else
      flash.now[:alert] = "#{t(:unable_to_update)} a #{ServiceOrder.model_name.human}"
      render :new
    end
  end

  def show
    @mode_of_transports = ModeOfTransport.active.select do |mode_of_transport|
      ModeOfTransportFinder.new(mode_of_transport, @service_order).compatible?
    end
  end

  def edit; end

  private

  def service_order_params
    params.require(:service_order).permit(:source_address, :product_code, :height, :width, :depth, :weight,
                                          :destination_address, :recipient, :recipient_phone, :total_distance)
                                            
  end

  def set_service_order
    @service_order = ServiceOrder.find(params[:id])
  end

  def formatted_recipient_phone
    @service_order.recipient_phone.insert(0, '(') 
    @service_order.recipient_phone.insert(3, ')') 
    @service_order.recipient_phone.insert(-5, '-') 
  end 
end