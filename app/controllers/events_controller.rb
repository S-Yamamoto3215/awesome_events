class EventsController < ApplicationController
  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)
    redirect_to @event, notice: '作成しました' if @event.save
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :content, :start_at, :end_at
    )
  end
end