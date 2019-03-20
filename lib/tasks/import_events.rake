# bundle exec rake import:events
require 'CSV'
namespace :import do
  desc 'import events'
  task events: :environment do
    logger = Logger.new("#{Rails.root}/log/envent_import.log")
    logger.info("======================== Started: event import #{Time.now} =========================")
    users = []
    CSV.foreach("#{Rails.root}/data/events.csv", headers: true) do |row|
      begin
        start_time = DateTime.parse(row[1])
        end_time = DateTime.parse(row[2])
        event = Event.create!(title: row[0], start_time:start_time, end_time: end_time, description:[3], is_all_day: row[5] == 'TRUE')
        rsvp_data = get_rsvp_data(row[4])
        rsvp_data.each do |data|
          format_data = data.split("#")
          #Get user from rsvp data
          user = User.find_by_username(format_data[0])
          #Find user overalping events
          user_events = UserEvent.joins(:event).where("user_id =? and events.start_time BETWEEN ? AND ?", user.id, start_time, end_time) if user
          # user has overlaping events and new event rsvp yes then update all overlaping evnt to no. make latest overlaping event to yes
          user_events.update(rsvp: 'no') if user_events.present? && format_data[1] == "yes"
          event.user_events.create!(user: user, rsvp: format_data[1]) if user
        end
      rescue StandardError => e
        logger.info("Not Imported: #{row.to_h}")
      end
    end
    logger.info("======================== Finished: event import #{Time.now} =========================")
  end
end

def get_rsvp_data(rsvp_data)
  rsvp_data.split(';')
end
