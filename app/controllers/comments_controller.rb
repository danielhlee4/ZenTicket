class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_ticket
  
    def create
        @comment = @ticket.comments.build(comment_params)
        @comment.user = current_user
  
        if @comment.save
            redirect_to @ticket, notice: 'Comment added successfully.'
        else
            flash.now[:alert] = 'Failed to add comment.'
            render 'tickets/show'
        end
    end
  
    private
  
    def set_ticket
        @ticket = Ticket.find(params[:ticket_id])
    end
  
    def comment_params
        params.require(:comment).permit(:content)
    end
end