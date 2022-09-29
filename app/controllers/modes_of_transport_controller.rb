class ModesOfTransportController < ApplicationController
  def index
    @modes_of_transport = ModeOfTransport.all
  end
end