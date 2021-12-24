class RoomsController < ApplicationController
  before_action :load_room, only: :show

  def show
    @furnitures = @room.furnitures
    @time_busy = @room.receipts.status_approved.select :from_time, :end_time
  end

  private

  def load_room
    @room = Room.includes(:images_blobs).find_by(id: params[:id])
    return if @room

    flash[:danger] = t "rooms.not_exist"
    redirect_to root_path
  end
end
