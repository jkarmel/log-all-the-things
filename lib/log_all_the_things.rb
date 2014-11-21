require "log_all_the_things/engine"

class Request < ActiveRecord::Base
end

class ActionController::Base
  around_filter :log_request

  def log_request
    Request.create!
    yield
  end
end

module LogAllTheThings
end
