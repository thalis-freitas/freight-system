class DeadlinesController < ApplicationController
  before_action :authenticate_user!
  before_action :admins_only, only: %i[new create edit update]
  before_action :set_deadline, only: %i[edit update]
  before_action :set_mode_of_transport_id, only: %i[new edit create update]

  def new
    @deadline = Deadline.new
  end

  def edit; end

  def create
    @deadline = Deadline.new(deadline_params)
    @deadline.mode_of_transport = @mode_of_transport
    if @deadline.save
      redirect_to @mode_of_transport,
                  notice: t(:deadline_successfully_registered)
    else
      flash.now[:alert] = t(:unable_to_register_deadline)
      render :new
    end
  end

  def update
    if @deadline == deadline_params
      no_modification_found
    elsif @deadline.update(deadline_params)
      redirect_to mode_of_transport_path(@deadline.mode_of_transport),
                  notice: t(:deadline_successfully_updated)
    else
      flash.now[:alert] = t(:unable_to_update_deadline)
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
