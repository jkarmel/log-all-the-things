require "log_all_the_things/engine"

class ActionController::Base
  around_filter :log_request
  def log_request
    cookies[:cookied_browser_id] ||= CookiedBrowser.create!.id
    request = Request.create! cookied_browser_id: cookies[:cookied_browser_id]
    Thread.current[:request] = request
    yield
  end
end
