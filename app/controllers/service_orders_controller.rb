class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, except:[:search]
  before_action :set_service_order, only:[:show, :edit, :update, :in_progress, :close, :close_overdue]
  before_action :formatted_recipient_phone, only:[:show]
  before_action :admins_only, only:[:new, :create, :edit, :update]
  before_action :can_only_edit_if_status_is_pending, only:[:edit, :update]
  before_action :closed_overdue_only_if_the_reason_is_present, only:[:close_overdue]

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

  def edit; end

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

  def in_progress
    @vehicles = Vehicle.in_operation.select{|vehicle| vehicle if vehicle.maximum_capacity >= @service_order.weight}
    if @vehicles.any?
      @service_order.in_progress!
      @service_order.started_in = Time.current
      @service_order.mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
      @service_order.register_price_and_deadline
      @service_order.vehicle = @vehicles.sort_by!{|vehicle| vehicle.maximum_capacity}.first
      @service_order.vehicle.on_delivery!
      redirect_to @service_order
    else
      @mode_of_transports = ModeOfTransport.active.select do |mode_of_transport|
        ModeOfTransportFinder.new(mode_of_transport, @service_order).compatible?
      end
      return redirect_to @service_order, alert: t(:oops_no_vehicle_available_to_meet_this_service_order)
    end
  end

  def close 
    @service_order.closed_in = Time.current
    if @service_order.on_deadline?
      @service_order.closed_on_deadline!
      @service_order.vehicle.in_operation!
      redirect_to @service_order
    else
      return redirect_to root_path
    end
  end

  def close_overdue
    if @service_order.on_deadline?
      return redirect_to root_path
    else
      @service_order.closed_in = Time.current
      @service_order.closed_in_arrears!
      @service_order.vehicle.in_operation!
      redirect_to @service_order
    end
  end

  def closeds
    @service_orders = ServiceOrder.all.select{|service_order| service_order.closed_on_deadline? || service_order.closed_in_arrears?}
  end

  def search 
    @code = params["query"]
    if user_signed_in?
      if @code.strip != ""
        @service_orders = ServiceOrder.where("code LIKE ?", "%#{@code}%")
      else
        flash.now[:alert] = "#{t(:need_to_fill_in_the_field_to_search)}"
      end
    else
      if @code.strip != "" && @code.length == 15
        @service_orders = ServiceOrder.where("code LIKE ?", "%#{@code}%")
      else
        flash.now[:alert] = "#{t(:to_perform_the_search_it_is_necessary_to_fill_in_the_field_with_the_complete_code)}"
      end
    end
  end

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

  def can_only_edit_if_status_is_pending
    unless @service_order.pending?
      return redirect_to root_path, alert: t(:unable_to_edit_a_service_order_that_has_already_been_started)
    end
  end

  def closed_overdue_only_if_the_reason_is_present
    unless @service_order.overdue_reason.present?
      return redirect_to root_path
    end
  end
end