class ApplicationMailer < ActionMailer::Base
  helper :application, :carts
  default from: "from@example.com"
  layout "mailer"
end
