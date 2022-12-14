class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i[show edit update in_maintenance in_operation]
  before_action :admins_only, only: %i[new create edit update in_maintenance in_operation]

  def index
    @vehicles = Vehicle.all
  end

  def show; end

  def new
    @vehicle = Vehicle.new
  end

  def edit; end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: t(:vehicle_successfully_registered)
    else
      flash.now[:alert] = t(:unable_to_register_vehicle)
      render :new
    end
  end

  def update
    if @vehicle == vehicle_params
      no_modification_found
    elsif @vehicle.update(vehicle_params)
      redirect_to vehicle_path(@vehicle), notice: t(:successfully_updated_vehicle)
    else
      flash.now[:alert] = t(:unable_to_update_vehicle)
      render :new
    end
  end

  def search
    @nameplate = params['query']
    if @nameplate.strip == ''
      flash.now[:alert] = t(:need_to_fill_in_the_field_to_search).to_s
    else
      @vehicles = Vehicle.where('nameplate LIKE ?', "%#{@nameplate}%")
    end
  end

  def in_maintenance
    @vehicle.in_maintenance!
    redirect_to @vehicle,
                notice: "#{t :vehicle_status_updated_for}: #{t(:in_maintenance)}"
  end

  def in_operation
    @vehicle.in_operation!
    redirect_to @vehicle,
                notice: "#{t :vehicle_status_updated_for}: #{t :in_operation}"
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:model, :brand, :year_of_manufacture, :maximum_capacity, :nameplate)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
