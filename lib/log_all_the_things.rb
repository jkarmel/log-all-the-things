require "log_all_the_things/engine"

class CookiedBrowser < ActiveRecord::Base
end


class Request < ActiveRecord::Base
  belongs_to :cookied_browser
end

class ActionController::Base
  around_filter :log_request

  def log_request
    cookies[:cookied_browser_id] ||= CookiedBrowser.create!.id
    Request.create cookied_browser_id: cookies[:cookied_browser_id]
    yield
  end
end

module LogAllTheThings
end
