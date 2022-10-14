class DeadlinesController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only:[:new, :create, :edit, :update]
  before_action :set_deadline, only:[:edit, :update]
  before_action :set_mode_of_transport_id, only:[:new, :edit, :create, :update]

  def new
    @deadline = Deadline.new
  end

  def create 
    @deadline = Deadline.new(deadline_params)
    @deadline.mode_of_transport = @mode_of_transport
    if @deadline.save
      redirect_to @mode_of_transport, notice: "#{t(:deadline_setting, count:1).capitalize} #{t(:successfully_registered)}"
    else
      flash.now[:alert] = "#{t(:could_not_register)} a #{t(:deadline_setting, count:1)}"
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

  def set_deadline
    @deadline = Deadline.find(params[:id])
  end
end