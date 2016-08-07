namespace :delayjob do
  desc "TODO"
  task mailmonth: :environment do
    User.all.each do |user|
      MonthlyWorker.perform_async MonthlyWorker::MAIL_MONTH, user.id
    end
  end
end
