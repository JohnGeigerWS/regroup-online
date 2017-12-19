class AddCompletedToSupportRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :support_requests, :completed, :boolean, default: false
  end
end
