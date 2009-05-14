class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :cart

  private

    def cart
      @cart = find_cart
    end

    def find_cart
      session[:cart] ||= Cart.new
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      do_require_user
    end
    
    def require_user_admin
      do_require_user('admin')
    end
    
    def do_require_user(role=nil)
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      else
        if(role && role != current_user.role)
          flash[:notice] = "You must be logged as #{role}"
          redirect_to root_path
        end
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to user_path(current_user)
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
