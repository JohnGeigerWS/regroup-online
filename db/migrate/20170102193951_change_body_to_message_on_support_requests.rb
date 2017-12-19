class ChangeBodyToMessageOnSupportRequests < ActiveRecord::Migration[5.0]
  def change
    rename_column :support_requests, :body, :message
  end
end
