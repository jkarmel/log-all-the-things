class AddCookiedBrowserToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :cookied_browser_id, :integer
  end
end
