class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :request_id
    end
  end
end
