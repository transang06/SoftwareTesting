class ReceiptMailer < ApplicationMailer
  def booking_approval user, receipt
    @user = user
    @receipt = receipt
    mail to: user.email, subject: t("admin.title_mail_approved")
  end

  def cancel_booking user, receipt
    @user = user
    @receipt = receipt
    mail to: user.email, subject: t("admin.title_mail_cancel")
  end
end
