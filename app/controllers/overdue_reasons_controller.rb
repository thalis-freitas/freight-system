class OverdueReasonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service_order_id, only:[:new, :create]

  def new
    @overdue_reason = OverdueReason.new
  end

  def create
    @overdue_reason = OverdueReason.new(params.require(:overdue_reason).permit(:overdue_reason))
    @overdue_reason.service_order = @service_order
    if @overdue_reason.save
      redirect_to @service_order
    else
      render :new
    end
  end

  private

  def set_service_order_id
    @service_order = ServiceOrder.find(params[:service_order_id])
  end
end