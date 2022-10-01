class ModeOfTransportsController < ApplicationController
  before_action :set_mode_of_transport, only:[:show, :edit, :update]
  before_action :mode_of_transport_params, only:[:create, :update]

  def index
    @mode_of_transports = ModeOfTransport.all
  end

  def new
    @mode_of_transport = ModeOfTransport.new
  end

  def create
    @mode_of_transport = ModeOfTransport.new(mode_of_transport_params)
    if @mode_of_transport.save
      redirect_to @mode_of_transport, notice: "#{ModeOfTransport.model_name.human} #{t :registered} #{t :successfully}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} #{ModeOfTransport.model_name.human}"
      render :new
    end
  end

  def show; end

  def edit; end

  def update 
    if @mode_of_transport == mode_of_transport_params
      flash.now[:alert] = "#{t(:no_modification_found)}"
      render :new
    else
      if @mode_of_transport.update(mode_of_transport_params)
        redirect_to mode_of_transport_path(@mode_of_transport), notice: "#{ModeOfTransport.model_name.human} #{t :updated} #{t :successfully}"
      else
        flash.now[:alert] = "#{t(:unable_to_update)} #{ModeOfTransport.model_name.human}"
        render :new
      end
    end
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