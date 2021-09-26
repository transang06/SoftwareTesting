class Admin::ReceiptsController < Admin::AdminsController
  before_action :load_receipt, :check_status, :load_user,
                only: %i(approved reject)
  after_action :format_js, only: %i(approved reject)

  def edit; end

  def update; end

  def approved
    @receipt.approved!
    ReceiptMailer.booking_approval(@user, @receipt).deliver_now
    flash.now[:success] = t "admin.change_success"
  rescue StandardError
    flash.now[:danger] = t("admin.change_failed")
  end

  def reject
    @receipt.cancelled_by_admin!
    ReceiptMailer.cancel_booking(@user, @receipt).deliver_now
    flash.now[:success] = t "admin.change_success"
  rescue StandardError
    flash.now[:danger] = t("admin.change_failed")
  end

  private

  def load_receipt
    @receipt = Receipt.find_by id: params[:id]
    return if @receipt

    flash[:warning] = t "receipt.nil"
    redirect_to admin_root_path
  end

  def load_user
    @user = User.find_by id: @receipt.user_id
    return if @user

    flash[:danger] = t "users.nil"
    redirect_to admin_root_path
  end

  def check_status
    return if @receipt.wait?

    flash[:danger] = t("admin.change_failed")
    redirect_to admin_root_path
  end

  def format_js
    respond_to do |format|
      format.js
    end
  end
end
