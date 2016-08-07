class UserWorker
  include Sidekiq::Worker

  START_EXAM = "start_to_exam"
  FINISH_EXAM = "finish_to_exam"

  def perform action, user_id, exam_id
    send "#{action}", user_id, exam_id
  end

  private
  ["start_to_exam", "finish_to_exam"].each do |send_email|
    define_method send_email do |user_id, exam_id|
      user = User.find_by id: user_id
      exam = Exam.find_by id: exam_id
      UsersMailer.send("#{send_email}", user, exam).deliver
    end
  end
end
