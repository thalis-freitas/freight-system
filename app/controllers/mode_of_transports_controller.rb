class ModeOfTransportsController < ApplicationController
  def index
    @mode_of_transports = ModeOfTransport.all
  end

  def new
    @mode_of_transport = ModeOfTransport.new
  end

  def create
    mode_of_transport_params = params.require(:mode_of_transport).permit(:name, :minimum_distance,
                                                                         :maximum_distance, :minimum_weight,
                                                                         :maximum_weight, :flat_rate)
    @mode_of_transport = ModeOfTransport.new(mode_of_transport_params)
    if @mode_of_transport.save
      redirect_to @mode_of_transport, notice: 'Modalidade de Transporte cadastrada com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar a Modalidade de Transporte'
      render :new
    end
  end

  def show
    @mode_of_transport = ModeOfTransport.find(params[:id])
  end
end