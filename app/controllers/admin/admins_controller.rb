class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!, :is_admin?
  layout "layouts/admin/application"

  def index
    @receipts = Receipt.includes(:user, :room).status_priority.latest
                       .page(params[:page]).per(Settings.per_page_18)
  end
end
