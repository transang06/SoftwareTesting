class RoomsController < ApplicationController
  before_action :load_room, only: :show

  def show
    @furnitures = @room.furnitures
    @time_busy = @room.receipts.status_approved.select :from_time, :end_time
  end

  def update
    @room = Room.find_by id: params[:id]
    if @room.update room_params
      flash.now[:success] = t ".update_success"
    else
      flash.now[:warning] = t ".update_not_success"
    end
    redirect_to admin_rooms_path
  end

  def room_params
    params.require(:room).permit :name, :type_room, :status, :hourly_price,
      :day_price, :monthly_price, :description, :discount, :amount_of_people, :photo
  end

  private

  def load_room
    @room = Room.includes(:images_blobs).find_by(id: params[:id])
    return if @room

    flash[:danger] = t "rooms.not_exist"
    redirect_to root_path
  end
end
