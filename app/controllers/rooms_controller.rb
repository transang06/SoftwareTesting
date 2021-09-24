class RoomsController < ApplicationController
  before_action :load_room, only: :show

  def show
    @furnitures = @room.furnitures
  end

  def search
    @room_ids = Room.room_on_busy(params[:from_time], params[:end_time])
    @rooms = Room.search_name_furnitures(params[:key])
    support_search
    render "static_pages/home"
  end

  private

  def load_room
    @room = Room.includes(:images_blobs).find_by(id: params[:id])
    return if @room

    flash[:danger] = t "rooms.not_exist"
    redirect_to root_path
  end

  def support_search
    @rooms = @rooms.or(Room.search_name_rooms(params[:key]))
                   .or(Room.search_time(@room_ids))
                   .or(Room.search_price(params[:min], params[:max]))
                   .distinct.page(params[:page]).per Settings.per_page_18
  end
end
