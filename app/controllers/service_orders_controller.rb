class ServiceOrdersController < ApplicationController
  before_action :authenticate_user!, except: [:search]
  before_action :set_service_order, only: %i[show edit update in_progress close close_overdue]
  before_action :formatted_phone, only: [:show]
  before_action :admins_only, only: %i[new create edit update]
  before_action :can_only_edit_if_status_is_pending, only: %i[edit update]
  before_action :closed_overdue_only_if_the_reason_is_present, only: [:close_overdue]

  def show
    @mode_of_transports = ModeOfTransport.active.select do |mode_of_transport|
      ModeOfTransportFinder.new(mode_of_transport, @service_order).compatible?
    end
  end

  def new
    @service_order = ServiceOrder.new
  end

  def edit; end

  def create
    @service_order = ServiceOrder.new(service_order_params)
    if @service_order.save
      redirect_to @service_order, notice: t(:service_order_successfully_registered)
    else
      flash.now[:alert] = t(:unable_to_register_service_order)
      render :new
    end
  end

  def update
    if @service_order == service_order_params
      no_modification_found
    elsif @service_order.update(service_order_params)
      redirect_to service_order_path(@service_order),
                  notice: t(:service_order_successfully_updated)
    else
      flash.now[:alert] = t(:unable_to_update_service_order)
      render :new
    end
  end

  def in_progress
    @vehicles = Vehicle.in_operation.select { |vehicle| vehicle if vehicle.maximum_capacity >= @service_order.weight }
    if @vehicles.any?
      set_so_in_progress
      redirect_to @service_order
    else
      @mode_of_transports = ModeOfTransport.active.select do |mode_of_transport|
        ModeOfTransportFinder.new(mode_of_transport, @service_order).compatible?
      end; redirect_to @service_order, alert: t(:oops_no_vehicle_available_to_meet_this_service_order)
    end
  end

  def close
    @service_order.closed_in = Time.current
    return redirect_to root_path unless @service_order.on_deadline?

    @service_order.closed_on_deadline! && @service_order.vehicle.in_operation!
    redirect_to @service_order
  end

  def close_overdue
    return redirect_to root_path if @service_order.on_deadline?

    @service_order.closed_in = Time.current
    @service_order.closed_in_arrears!
    @service_order.vehicle.in_operation!
    redirect_to @service_order
  end

  def closeds
    @service_orders = ServiceOrder.all.select do |service_order|
      service_order.closed_on_deadline? || service_order.closed_in_arrears?
    end
  end

  def search
    @code = params['query']
    if user_signed_in?
      employee_search_mode
    elsif @code.strip != '' && @code.length == 15
      @service_orders = ServiceOrder.where('code LIKE ?', "%#{@code}%")
    else
      flash.now[:alert] = t(:to_perform_the_search_it_is_necessary_to_fill_in_the_field_with_the_complete_code)
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

  def can_only_edit_if_status_is_pending
    return if @service_order.pending?

    redirect_to root_path, alert: t(:unable_to_edit_a_service_order_that_has_already_been_started)
  end

  def closed_overdue_only_if_the_reason_is_present
    redirect_to root_path if @service_order.overdue_reason.blank?
  end

  def set_so_in_progress
    @service_order.in_progress! && @service_order.started_in = Time.current
    @service_order.mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
    @service_order.register_price_and_deadline
    @service_order.vehicle = @vehicles.sort_by!(&:maximum_capacity).first
    @service_order.vehicle.on_delivery!
  end

  def employee_search_mode
    flash.now[:alert] = t(:need_to_fill_in_the_field_to_search) if @code.strip == ''
    @service_orders = ServiceOrder.where('code LIKE ?', "%#{@code}%")
  end
end
