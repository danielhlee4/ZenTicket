class SessionsController < ApplicationController
    layout 'sessions', only: [:new]
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to tickets_path, notice: 'Logged in successfully'
        else
            flash.now[:alert] = 'Email or password is invalid'
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: 'Logged out successfully'
    end
end
