class SessionController < Devise::SessionsController
  def new
    super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    puts "aslkdfjalskdfjlaksdfasdfsadf"
    puts current_user.is_active
    if !current_user.is_active
      sign_out(resource_name)
      set_flash_message(:notice, "User is not set active")
      redirect_to new_user_session_path
    else
      if (!session[:return_to].blank? )
        redirect_to session[:return_to]
        session[:return_to] = nil
      else
        respond_with resource, :location => after_sign_in_path_for(resource)
      end
    end
  end
end
