class HomeController < ApplicationController
  def index
    @service_orders = ServiceOrder.all
  end
end