class DeadlinesController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only:[:new, :create, :edit, :update]
  before_action :set_deadline, only:[:edit, :update]

  def new
    @deadline = Deadline.new
    @mode_of_transports = ModeOfTransport.order(:name)
  end

  def create 
    @deadline = Deadline.new(deadline_params)
    @mode_of_transport = @deadline.mode_of_transport
    if @deadline.save
      redirect_to @mode_of_transport, notice: "#{t(:deadline_setting, count:1).capitalize} #{t(:successfully_registered)} #{t :for_the_modality} #{@mode_of_transport.name}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} a #{t(:deadline_setting, count:1)}"
      @mode_of_transports = ModeOfTransport.order(:name)
      render :new
    end
  end

  def edit; end

  def update 
    if @deadline == deadline_params
      flash.now[:alert] = "#{t(:no_modification_found)}"
      render :edit
    elsif @deadline.update(deadline_params)
      redirect_to mode_of_transport_path(@deadline.mode_of_transport), notice: "#{t(:deadline_setting, count:1).capitalize} #{t :successfully_updated}"
    else
      flash.now[:alert] = "#{t(:unable_to_update)} a #{t(:deadline_setting, count:1)}" 
      render :edit
    end
  end

  private 

  def deadline_params
    params.require(:deadline).permit(:minimum_distance, :maximum_distance, :estimated_time, :mode_of_transport_id)
  end

  def admins_only
    unless current_user.admin?
      return redirect_to root_path, alert: t(:unauthorized_access)
    end
  end

  def set_deadline
    @deadline = Deadline.find(params[:id])
  end
end