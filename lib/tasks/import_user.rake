# bundle exec rake import:users
require 'CSV'
namespace :import do
  desc 'import users'
  task users: :environment do
    logger = Logger.new("#{Rails.root}/log/user_import.log")
    logger.info("======================== Started: user import #{Time.now} =========================")
    users = []
    CSV.foreach("#{Rails.root}/data/users.csv", headers: true) do |row|
      begin
        user = User.create!(row.to_h)
      rescue StandardError => e
        logger.info("Not Imported: #{row.to_h}")
      end
    end
    logger.info("======================== Finished: user import #{Time.now} =========================")
  end
end
