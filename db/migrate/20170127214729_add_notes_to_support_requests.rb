class AddNotesToSupportRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :support_requests, :notes, :text
  end
end
