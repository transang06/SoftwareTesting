class StaticPagesController < ApplicationController
  before_action :load_room_busy, only: :home

  def home
    @rooms = @q.result.not_in(@room_ids_busy).latest
               .distinct.page(params[:page]).per Settings.per_page_18
  end

  def contact; end

  def about; end

  def help; end

  private

  def load_room_busy
    @room_ids_busy = Receipt.status_approved
                            .on_busy_from(params[:from_time])
                            .on_busy_to(params[:end_time])
                            .select(:room_id).distinct
  end
end
