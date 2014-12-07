class Request < ActiveRecord::Base
  belongs_to :browser, class_name: 'CookiedBrowser', foreign_key: :cookied_browser_id
end
