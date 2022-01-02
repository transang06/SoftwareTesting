class Admin::RoomsController < Admin::AdminsController
  def index
    @rooms = Room.page(params[:page]).per(Settings.per_page_18)
  end

  def edit
    @room = Room.find_by id: params[:id]
  end
end
