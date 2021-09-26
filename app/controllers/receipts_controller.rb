class ReceiptsController < ApplicationController
  include CartsHelper
  before_action :store_location, :logged_in_user
  before_action :load_room_in_cart, :load_room, only: :create

  def index
    @receipts = current_user.receipts
                            .page(params[:page]).per(Settings.per_page_18)
  end

  def show
    @receipt = current_user.receipts.find_by id: params[:id]
    return if @receipt

    flash[:danger] = t "receipt.not_permissions"
    redirect_to receipts_path
  end

  def create
    if sp_save
      flash[:success] = t "receipt.booking_successful"
      session[:cart].delete params[:room_id]
      redirect_to @receipt
    else
      flash[:danger] = t "receipt.booking_fail"
      redirect_to root_path
    end
  end

  def cancel_booking
    @receipt = current_user.receipts.find_by id: params[:id]
    @receipt.cancelled_by_you! if @receipt.wait?
    redirect_to @receipt
  end

  private

  def sp_save
    into_money = sp_money @cart["end_time"], @cart["from_time"]
    @receipt = current_user.receipts.new
    @receipt.payment = "TP bank"
    @receipt.room_id = params[:room_id]
    @receipt.from_time = @cart["from_time"]
    @receipt.end_time = @cart["end_time"]
    @receipt.hourly_price = @room.hourly_price
    @receipt.day_price = @room.day_price
    @receipt.monthly_price = @room.monthly_price
    @receipt.into_money = into_money
    @receipt.paid = into_money
    @receipt.paid_at = DateTime.now
    begin
      @receipt.save!
    rescue
      return false
    end
  end

  def load_room_in_cart
    @cart = session[:cart][params[:room_id]]
    return if @cart

    flash[:warning] = t "cart.not_exist_room"
    redirect_to carts_path
  end

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room

    flash[:warning] = t "rooms.not_exist"
    redirect_to carts_path
  end
end
