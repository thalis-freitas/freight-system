class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def admins_only
    return if current_user.admin?

    redirect_to root_path, alert: t(:unauthorized_access)
  end

  def set_mode_of_transport_id
    @mode_of_transport = ModeOfTransport.find(params[:mode_of_transport_id])
  end

  def no_modification_found
    flash.now[:alert] = t(:no_modification_found)
    render :edit
  end

  def formatted_phone
    @service_order.recipient_phone.insert(0, '(')
    @service_order.recipient_phone.insert(3, ')')
    @service_order.recipient_phone.insert(-5, '-')
  end
end
