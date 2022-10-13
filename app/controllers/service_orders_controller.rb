class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_order, only:[:show]
  before_action :formatted_recipient_phone, only:[:show]
  before_action :admins_only, only:[:new, :create]

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

  def show; end

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

  def admins_only
    unless current_user.admin?
      return redirect_to root_path, alert: t(:unauthorized_access)
    end
  end
end