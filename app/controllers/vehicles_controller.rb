class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :vehicle_params, only:[:create]
  before_action :set_vehicle, only:[:show, :edit, :update]
  before_action :admins_only, only:[:new, :create, :edit, :update]
  
  def index 
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      redirect_to @vehicle, notice: "#{Vehicle.model_name.human} #{t(:registered)} #{t(:successfully)}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} o #{Vehicle.model_name.human}"
      render :new
    end
  end

  def show; end

  def edit; end

  def update 
    if @vehicle == vehicle_params
      flash.now[:alert] = "#{t(:no_modification_found)}"
      render :new
    elsif @vehicle.update(vehicle_params)
      redirect_to vehicle_path(@vehicle), notice: "#{Vehicle.model_name.human} #{t :updated} #{t :successfully}"
    else
      flash.now[:alert] = "#{t(:unable_to_update)} o #{Vehicle.model_name.human}"
      render :new
    end
  end

  private 

  def vehicle_params
    params.require(:vehicle).permit(:model, :brand, :year_of_manufacture, :maximum_capacity, :nameplate)
  end

  def set_vehicle 
    @vehicle = Vehicle.find(params[:id])
  end

  def admins_only
    unless current_user.admin?
      return redirect_to root_path, alert: t(:unauthorized_access)
    end
  end
end