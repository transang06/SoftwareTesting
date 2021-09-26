class StaticPagesController < ApplicationController
  def home
    @rooms = Room.latest.page(params[:page]).per Settings.per_page_18
  end

  def contact; end

  def about; end

  def help; end
end
