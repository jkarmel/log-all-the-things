require "log_all_the_things/engine"

class CookiedBrowser < ActiveRecord::Base
end


class Request < ActiveRecord::Base
  belongs_to :cookied_browser
end

class Event < ActiveRecord::Base
  belongs_to :request

  def self.publish(data)
    create! request: Thread.current[:request]
  end

end

class ActionController::Base
  around_filter :log_request

  def log_request
    cookies[:cookied_browser_id] ||= CookiedBrowser.create!.id
    request = Request.create cookied_browser_id: cookies[:cookied_browser_id]
    Thread.current[:request] = request
    yield
  end
end

module LogAllTheThings
end
