class ModeOfTransportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mode_of_transport, only: %i[show edit update inactive active]
  before_action :admins_only, only: %i[new create edit update active inactive]

  def index
    @mode_of_transports = ModeOfTransport.all
  end

  def show; end

  def new
    @mode_of_transport = ModeOfTransport.new
  end

  def edit; end

  def create
    @mode_of_transport = ModeOfTransport.new(mode_of_transport_params)
    if @mode_of_transport.save
      redirect_to @mode_of_transport, notice: t(:mode_of_transport_successfully_registered)
    else
      flash.now[:alert] = t(:unable_to_register_mode_of_transport)
      render :new
    end
  end

  def update
    if @mode_of_transport == mode_of_transport_params
      no_modification_found
    elsif @mode_of_transport.update(mode_of_transport_params)
      redirect_to mode_of_transport_path(@mode_of_transport),
                  notice: t(:mode_of_transport_successfully_updated)
    else
      flash.now[:alert] = t(:unable_to_update_mode_of_transport)
      render :new
    end
  end

  def active
    @mode_of_transport.active!
    redirect_to @mode_of_transport,
                notice: t(:mode_of_transport_activated_successfully)
  end

  def inactive
    @mode_of_transport.inactive!
    redirect_to @mode_of_transport,
                notice: t(:mode_of_transport_disabled_successfully)
  end

  private

  def set_mode_of_transport
    @mode_of_transport = ModeOfTransport.find(params[:id])
  end

  def mode_of_transport_params
    params.require(:mode_of_transport).permit(:name, :minimum_distance,
                                              :maximum_distance, :minimum_weight,
                                              :maximum_weight, :flat_rate)
  end
end
