class TicketsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update]

    def index
        if current_user.admin?
            @tickets = Ticket.all
        else
            @tickets = current_user.tickets
        end
    end
  
    def show
        # @ticket is already set by the before_action
    end
  
    def new
        @ticket = Ticket.new
    end
  
    def create
        user = User.find_by(email: params[:ticket][:user_email]) if current_user.admin?
        @ticket = Ticket.new(ticket_params)
        @ticket.user = current_user.admin? && user ? user : current_user
        @ticket.status = "Open" # Default status is 'Open'

        if @ticket.save
            redirect_to @ticket, notice: 'Ticket created successfully.'
        else
            flash.now[:alert] = @ticket.errors.full_messages.to_sentence
            render :new
        end
    end
  
    def edit
        # @ticket is already set by the before_action
    end
  
    def update
        if @ticket.update(ticket_params)
            redirect_to @ticket, notice: 'Ticket updated successfully.'
        else
            flash.now[:alert] = @ticket.errors.full_messages.to_sentence
            render :edit
        end
    end
  
    def destroy
        @ticket.destroy
        redirect_to tickets_path, notice: 'Ticket deleted successfully.'
    end
  
    private

    def set_ticket
        @ticket = Ticket.find(params[:id])
    end

    def ticket_params
        permitted_params = [:title, :description]
        permitted_params << :user_id << :priority_level << :status << :resolution_details << :internal_note if current_user.admin?
        params.require(:ticket).permit(permitted_params)
    end
    
    def authorize_user
        unless current_user.admin? || current_user == @ticket.user
            redirect_to tickets_path, alert: 'You are not authorized to edit this ticket'
        end
    end
end
  