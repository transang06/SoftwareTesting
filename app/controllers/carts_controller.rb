class CartsController < ApplicationController
  before_action :load_room, :check_time_vali,
                :check_time_busy, only: %i(add change)
  before_action :check_exist_room_id, only: %i(change remove)

  def index; end

  def add
    sp_change
    flash.now[:success] = t "cart.add_success"
  end

  def change
    sp_change
    flash[:success] = t "cart.update_success"
    redirect_to carts_path
  end

  def remove
    session[:cart].delete params[:room_id]
    flash[:success] = t "cart.delete_success"
    redirect_to carts_path
  end

  private

  def check_time_vali
    from_time = params[:from_time].to_datetime
    end_time = params[:end_time].to_datetime
    time_compare from_time, end_time
  rescue StandardError
    flash[:danger] = t "cart.date_invalid"
    redirect_to @room
  end

  def time_compare from_time, end_time
    one_hour = Settings.hour_1.hour
    check_time = from_time.to_datetime >= DateTime.now + one_hour
    check_time &= end_time.to_datetime >= DateTime.now + one_hour
    check_time &= end_time.to_datetime >= from_time.to_datetime + one_hour
    return if check_time

    flash[:danger] = t "cart.date_invalid"
    redirect_to @room
  end

  def sp_change
    session[:cart][params[:room_id]] = {
      from_time: params[:from_time],
      end_time: params[:end_time]
    }
  end

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room

    flash[:warning] = t "rooms.not_exist"
    redirect_to carts_path
  end

  def check_exist_room_id
    return if session[:cart][params[:room_id]]

    flash[:warning] = t "cart.not_exist_room"
    redirect_to carts_path
  end

  def check_time_busy
    @time_busy = @room.receipts.status_approved
                      .on_busy params[:from_time], params[:end_time]
    return unless @time_busy.any?

    flash[:warning] = t "cart.booked"
    redirect_to @room
  end
end
