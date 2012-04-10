class Notification < ActiveRecord::Base
  include Dispatcher

  def periodicity_time
    transform = { "daily" => 60*60*24,
                  "minutely" => 60,
                  "hourly" => 60*60 }

   if seconds = transform[periodicity]
     seconds
   else
     periodicity.to_i
   end
  end
end
