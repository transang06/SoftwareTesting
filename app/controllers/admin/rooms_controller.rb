class Admin::RoomsController < Admin::AdminsController
  def index
    @rooms = @q.result.latest
      .page(params[:page]).per Settings.per_page_18
  end

  def edit
    @room = Room.find_by id: params[:id]
  end

  def new
    @room = Room.new
    render :edit
  end
end
