class TicketsController < ApplicationController
  def new
    raise ActionController::RoutingError
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end

    redirect_to event, notice: 'このイベントに参加登録しました' if @ticket.save
  end
end
