class TicketsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket, only: [:show, :edit, :update, :destroy]

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
        @ticket = Ticket.new(ticket_params)
        @ticket.status = "Open" # Default status is 'Open'
        @ticket.user = current_user

        if @ticket.save
            redirect_to @ticket, notice: 'Ticket created successfully.'
        else
            flash.now[:alert] = @ticket.errors.full_messages.to_sentence
            render :new
        end
    end
  
    def edit
        @ticket = Ticket.find(params[:id])
    end
  
    def update
        @ticket = Ticket.find(params[:id])
        if @ticket.update(ticket_params)
            redirect_to @ticket, notice: 'Ticket updated successfully.'
        else
            render :edit
        end
    end
  
    def destroy
        @ticket = Ticket.find(params[:id])
        @ticket.destroy
        redirect_to tickets_path, notice: 'Ticket deleted successfully.'
    end
  
    private

    def set_ticket
        @ticket = Ticket.find(params[:id])
    end
  
    def ticket_params
        params.require(:ticket).permit(:title, :description, :priority_level, :status, :resolution_details)
    end
end
  