class UsersMailer < ActionMailer::Base
  default from: ENV["GMAIL_USERNAME"]

  ["start_to_exam", "finish_to_exam"].each do |send_email|
    define_method send_email do |user, exam|
      @user = user
      @exam = exam
      mail to: @user.email, subject: t("mail.#{send_email}",
        name: @exam.subject.name)
    end
  end

  def mail_month user_id
    @user = User.find_by id: user_id
    if @user.present? && @user.exams.any?
      @exams = @user.exams
      scores = @exams.collect {|exam| exam.score}
      total = scores.inject {|sum, v| sum + v}.to_f
      count = scores.count
      @average = (total / count).to_s.html_safe
      mail to: @user.email, subject: t("mail.average")
    end
  end
end
