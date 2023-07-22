class ApplicationController < ActionController::Base
    before_action :set_current_user 

    def set_current_user
        if session[:user_id]
            @current_user = User.find(session[:user_id])
        else 
            @current_user = User.create()
            session[:user_id] = @current_user.id
        end
    end
end
