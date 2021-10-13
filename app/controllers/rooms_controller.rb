class RoomsController < ApplicationController
  before_action :load_room, only: :show
  before_action :load_room_busy, only: :search

  def show
    @furnitures = @room.furnitures
    @time_busy = @room.receipts.status_approved.select :from_time, :end_time
  end

  def search
    @rooms = Room.name_has(params[:key])
                 .price_greater(params[:min])
                 .price_less(params[:max])
                 .not_in(@room_ids_busy)
                 .distinct.page(params[:page]).per Settings.per_page_18
    render "static_pages/home"
  end

  private

  def load_room
    @room = Room.includes(:images_blobs).find_by(id: params[:id])
    return if @room

    flash[:danger] = t "rooms.not_exist"
    redirect_to root_path
  end

  def load_room_busy
    @room_ids_busy = Receipt.status_approved
                            .on_busy_from(params[:from_time])
                            .on_busy_to(params[:end_time])
                            .select(:room_id).distinct
  end
end
