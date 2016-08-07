set :environment, "development"
set :output, "/home/xoan/log.log"

every "0 0 28-31 * *" do
  rake "delayjob:mailmonth"
end
