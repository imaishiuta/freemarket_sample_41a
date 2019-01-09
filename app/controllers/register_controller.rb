class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_recaptcha, only: [:create]
  prepend_before_action :

  private

  def check_recaptcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) {render: new}
  end

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :password, :email, :password, :password_confirmation]
  end

end
