class SessionsController < ApplicationController
    layout 'sessions', only: [:new]
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to root_path, notice: 'Logged in successfully'
        else
            flash.now[:alert] = 'Email or password is invalid'
            render :new
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to login_path, notice: 'Logged out successfully'
    end
end
