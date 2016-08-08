class MonthlyWorker
  include Sidekiq::Worker

  MAIL_MONTH = 1

  def perform action, user_id
    case action
    when MAIL_MONTH
      send_email_when_end_month user_id
    end
  end

  private
  def send_email_when_end_month user_id
    UsersMailer.mail_month(user_id).deliver_now
  end
end
