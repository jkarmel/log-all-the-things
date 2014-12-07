class Event < ActiveRecord::Base
  belongs_to :request

  def self.publish(data)
    create! request: Thread.current[:request]
  end
end
